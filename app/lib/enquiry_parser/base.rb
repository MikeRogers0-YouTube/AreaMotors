class EnquiryParser::Base

  def initialize(content)
    @content = content
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

  private
  def content
    @content
  end

  def doc
    @doc ||= Nokogiri::HTML(content)
  end
end
