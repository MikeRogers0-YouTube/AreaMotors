class EnquiryParser::CarsForSale < EnquiryParser::Base
  def name
  end

  def email
  end

  def message
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

  def listing_reference
  end

  private
  def listing_table_value(column)
    doc.css('div > table > tr').select do |node|
      node.text.strip.starts_with?("#{column}:")
    end.first.css('td').last.text
  end
end
