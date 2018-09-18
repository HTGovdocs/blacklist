# frozen_string_literal: true

# reworked quickstart for GOOGLE API from here:
# https://developers.google.com/sheets/quickstart/ruby
require 'dotenv'
require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'set'

class Gsheet
  attr_accessor :oclcs

  Dotenv.load!
  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
  APPLICATION_NAME = 'Registry Blacklist'
  CREDENTIALS_PATH = ENV['CREDENTIALS_PATH']
  SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY

  def self.sheet_id; end

  ##
  # Ensure valid credentials, either by restoring from the saved credentials
  # files or intitiating an OAuth2 authorization. If authorization is required,
  # the user's default browser will be launched to approve the request.
  #
  # @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
  def self.authorize
    FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

    client_id = Google::Auth::ClientId.from_file(ENV['CLIENT_SECRETS_PATH'])
    token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(
      client_id, SCOPE, token_store
    )
    user_id = 'default'
    credentials = authorizer.get_credentials(user_id)
    if credentials.nil?
      url = authorizer.get_authorization_url(
        base_url: OOB_URI
      )
      puts 'Open the following URL in the browser and enter the ' \
           'resulting code after authorization'
      puts url
      code = gets
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI
      )
    end
    credentials
  end

  def self.get_data(sheet_name = 'Sheet1')
    service = Google::Apis::SheetsV4::SheetsService.new
    service.client_options.application_name = APPLICATION_NAME
    service.authorization = authorize

    range = "#{sheet_name}!A1:A"
    response = service.get_spreadsheet_values(sheet_id, range)
    raise 'Could not find any data' if response.values.nil? ||
                                       response.values.empty?
    response.values.flatten
  end
end
