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
  validates :source_url, presence: true, uniqueness: true
  validates :state, presence: true

  attr_accessor :source_html

  def self.create_from_source(source: nil, source_url: nil, source_html: nil)
    enquiry = new(source: source, source_url: source_url, source_html: source_html).tap do |enquiry|
      enquiry.attributes = enquiry.parser.attributes
    end
    enquiry.save
    enquiry
  end

  def parser
    @parser ||= ("EnquiryParser::#{source.to_s.camelize}").constantize.new(source_html)
  end
end
