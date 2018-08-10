class EnquiryParser::CarsForSale < EnquiryParser::Base
  def name
    doc.to_html.match(/(.*) \((.*)\) has contacted you about a car for sale/)[1].strip
  end

  def email
    doc.to_html.match(/(.*) \((.*)\) has contacted you about a car for sale/)[2].strip
  end

  def message
    doc.to_html.match(/He asked: \<br\>(.*)\<br\>\<br\>/sm)[1].strip
  end

  def listing_make
    listing_table_value('Make')
  end

  def listing_model
    listing_table_value('Model')
  end

  def listing_year
    listing_table_value('Year')
  end

  def listing_colour
    listing_table_value('Colour')
  end

  def listing_url
    doc.css('div > a').last.attributes['href'].value
  end

  def listing_reference; end

  private
  def listing_table_value(column)
    doc.css('div > table > tr').select do |node|
      node.text.strip.starts_with?("#{column}:")
    end.first.css('td').last.text
  end
end
