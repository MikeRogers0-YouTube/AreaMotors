class Enquiry < ApplicationRecord
  enum source: { 
    a_m_direct: 10, 
    cars_for_sale: 20, 
  }

  enum state: { 
    open: 10, 
    done: 20, 
    invalid: 30, 
  }, _prefix: :state

  validates :name, presence: true
  validates :email, presence: true
  validates :message, presence: true
  validates :source, presence: true
  validates :state, presence: true

  def self.new_from_source(source: nil, source_url: nil)
    enquiry_parser = ("EnquiryParser::#{source.to_s.camelize}").constantize.new('<!-- Will read a file -->')

    return new unless enquiry_parser.valid?

    new.tap do |enquiry|
      enquiry.source = source
      enquiry.source_url = source_url
      enquiry.attributes = enquiry_parser.attributes
    end
  end
end
