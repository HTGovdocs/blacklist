# frozen_string_literal: true

require 'pp'
require 'yaml'
require 'filter/whitelist'
require 'filter/blacklist'

module Filter
  # Determine if this is a feddoc based on 008 and 086 and 074
  # and OCLC blacklist
  # marc - ruby-marc repesentation of source
  def fed_doc?(m = nil)
    @marc = m unless m.nil?

    # check the blacklist
    oclc_resolved&.each do |o|
      return true if Whitelist.oclcs.include? o
      return false if Blacklist.oclcs.include? o
    end

    # accept
    (
      u_and_f? ||
      sudocs&.any? ||
      gpo_item_numbers&.any? ||
      approved_author? ||
      approved_added_entry? ) &&
    # reject
      !reject_because_of_field? &&
      !reject_source_record?

  end

  @@rejected_source_records = YAML.load_file(
    File.join(File.dirname(__FILE__),
              '../config/rejected_source_records.yml')
  )
  def reject_source_record?
    @@rejected_source_records[org_code]&.include? local_id
  end

  @@rejected_fields = YAML.load_file(
    File.join(File.dirname(__FILE__),
              '../config/rejected_fields.yml')
  )
  def reject_because_of_field?
    @@rejected_fields.each do |field, values|
      values.each do |value|
        return value if ([public_send(field)].flatten & [value].flatten).any?
      end
    end
    false
  end
end
