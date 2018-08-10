class EnquiryParser::Base

  attr_accessor :content
  def initialize(content)
    self.content = content
  end

  def valid?
    false
  end

  def attributes
    {
      'name': name,
      'email': email,
      'message': message,
      'listing_make': listing_make,
      'listing_model': listing_model,
      'listing_year': listing_year,
      'listing_colour': listing_colour,
      'listing_url': listing_url,
      'listing_reference': listing_reference
    }
  end
end
