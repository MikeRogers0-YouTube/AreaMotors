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

  def self.create_from_source(source: nil, source_url: nil)
    create(source: source, source_url: source_url).tap do |enquiry|
      enquiry.attributes = enquiry.parser.attributes
    end
  end

  def parser
    @parser ||= ("EnquiryParser::#{source.to_s.camelize}").constantize.new(source_html)
  end

  def source_html
    '<!-- Will read a file -->'
  end
end
