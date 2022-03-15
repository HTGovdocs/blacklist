# frozen_string_literal: true

require "pp"
require "yaml"
require "filter/approved_list"
require "filter/rejected_list"

module Filter
  class << self
    attr_accessor :rejected_source_records
    attr_accessor :rejected_fields
    attr_accessor :accepted_fields
  end

  # Determine if this is a feddoc based on 008 and 086 and 074
  # and OCLC rejected list
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
      oclc_resolved&.any? { |o| ApprovedList.oclcs.include? o } ||
      accept_because_of_field?
    ) &&
      !rejected?
  end

  @accepted_fields = YAML.load_file(
    File.join(File.dirname(__FILE__),
      "../config/accepted_fields.yml")
  )
  def accept_because_of_field?
    Filter.accepted_fields.each do |field, values|
      found = remove_non_word_chars(public_send(field)) & remove_non_word_chars(values)
      return found if found.any?
    end
    false
  end

  def rejected?
    oclc_resolved&.any? { |o| RejectedList.oclcs.include? o } ||
      reject_source_record? ||
      reject_because_of_field?
  end

  @rejected_source_records = YAML.load_file(
    File.join(File.dirname(__FILE__),
      "../config/rejected_source_records.yml")
  )
  def reject_source_record?
    Filter.rejected_source_records[org_code]&.include? local_id
  end

  @rejected_fields = YAML.load_file(
    File.join(File.dirname(__FILE__),
      "../config/rejected_fields.yml")
  )
  def reject_because_of_field?
    Filter.rejected_fields.each do |field, values|
      found = remove_non_word_chars(public_send(field)) & remove_non_word_chars(values)
      return found if found.any?
    end
    false
  end

  def remove_non_word_chars(field_values)
    [(field_values || "")].flatten.map do |v|
      v.downcase.gsub(/[^[[:word:]]]/, "")
    end.reject(&:empty?)
  end
end
