class EnquiryParser::Base < Struct.new(:content, keyword_init: true)

  def valid?
    true
  end

  def attributes
    {}
  end
end
