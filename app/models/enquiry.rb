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
  validates :listing_url, presence: true, uniqueness: true
  validates :state, presence: true

  before_create :verify_email_quality!

  attr_accessor :source_html

  # TODO: A scope for ordering by newest_first?
  scope :search, ->(query){
    where(
      %i(name email)
      .collect { |field| arel_table[field].matches("%#{query}%") }
      .inject(:or)
    )
  }

  def self.create_from_source(source: nil, source_html: nil)
    enquiry = new(source: source, source_html: source_html)
    enquiry.attributes = enquiry.parser.attributes
    enquiry.save
    enquiry
  end

  def parser
    @parser ||= ("EnquiryParser::#{source.to_s.camelize}").constantize.new(source_html)
  end

  def verify_email_quality!
    return if ValidEmail2::Address.new(email).valid?
    self.state = :invalid
  end
end
