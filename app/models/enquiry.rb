class Enquiry < ApplicationRecord
  enum source: { 
    a_m_direct: 10, 
    cars_for_sale: 20, 
  }

  enum state: { 
    open: 10, 
    done: 20, 
    invalid: 30, 
    custom: 40, 
  }, _prefix: :state

  validates :name, presence: true
  validates :email, presence: true
  validates :message, presence: true
  validates :source, presence: true
  validates :listing_url, presence: true
  validates :state, presence: true
  validates :custom_state, presence: true, if: :state_custom?

  before_create :verify_email_quality!

  attr_accessor :source_html

  scope :newest_first, ->{ order(created_at: :desc) }
  scope :search, ->(query){
    where(
      %i(name email)
      .collect { |field| arel_table[field].matches("%#{query}%") }
      .inject(:or)
    )
  }

  def self.create_from_source(source: nil, source_html: nil)
    enquiry = new(source: source, source_html: source_html)
    enquiry.set_attributes_from_parser!
    enquiry.save
    enquiry
  end

  def self.options_for_state
    states.keys.collect do |state|
      [I18n.t("activerecord.enums.enquiry.states.#{state}"), state]
    end
  end

  def set_attributes_from_parser!
    begin
      self.attributes = parser.attributes
    rescue
      self.attributes = {}
    end
  end

  private
  def parser
    @parser ||= ("EnquiryParser::#{source.to_s.camelize}").constantize.new(source_html)
  end

  def verify_email_quality!
    return if ValidEmail2::Address.new(email).valid?
    self.state = :invalid
  end
end
