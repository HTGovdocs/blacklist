# frozen_string_literal: true

require 'pp'
require 'yaml'
require 'filter/whitelist'
require 'filter/blacklist'

module Filter
  class << self
    attr_accessor :rejected_source_records
    attr_accessor :rejected_fields
  end

  # Determine if this is a feddoc based on 008 and 086 and 074
  # and OCLC blacklist
  # marc - ruby-marc repesentation of source
  def fed_doc?(marc_record = nil)
    @marc = marc_record unless marc_record.nil?

    # accept
    (
      u_and_f? ||
      sudocs&.any? ||
      gpo_item_numbers&.any? ||
      approved_author? ||
      approved_added_entry? ||
      oclc_resolved&.any? { |o| Whitelist.oclcs.include? o }
    ) &&
      !rejected?
  end

  def rejected?
    oclc_resolved&.any? { |o| Blacklist.oclcs.include? o } ||
      reject_source_record? ||
      reject_because_of_field?
  end

  @rejected_source_records = YAML.load_file(
    File.join(File.dirname(__FILE__),
              '../config/rejected_source_records.yml')
  )
  def reject_source_record?
    Filter.rejected_source_records[org_code]&.include? local_id
  end

  @rejected_fields = YAML.load_file(
    File.join(File.dirname(__FILE__),
              '../config/rejected_fields.yml')
  )
  def reject_because_of_field?
    Filter.rejected_fields.each do |field, values|
      values.each do |value|
        return value if ([public_send(field)].flatten & [value].flatten).any?
      end
    end
    false
  end
end
