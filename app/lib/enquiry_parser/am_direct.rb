class EnquiryParser::AMDirect < EnquiryParser::Base
  def name
    doc.css('.customer-details #name').text
  end

  def email
    doc.css('.customer-details #email').text
  end

  def message
    customer_details = doc.css('.customer-details')
    customer_details.css('label, label + br, span, span + br, span + br + br').remove
    customer_details.inner_html.strip
  end

  def listing_make
    doc.css('.vehicle-details #make').first.text
  end

  def listing_model
    doc.css('.vehicle-details #make').last.text
  end

  def listing_year
    doc.css('.vehicle-details #year').text
  end

  def listing_colour
    doc.css('.vehicle-details #colour').text
  end

  def listing_url
    doc.css('.vehicle-details a').first.attributes['href'].value
  end

  def listing_reference
    doc.css('.vehicle-details #listing-ref').text
  end
end
