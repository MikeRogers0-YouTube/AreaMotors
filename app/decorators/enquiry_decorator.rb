class EnquiryDecorator < Draper::Decorator
  delegate_all

  def message
    h.sanitize(object.message, tags: %w(br))
  end

  def listing_url
    h.link_to object.listing_url, object.listing_url, target: '_blank'
  end

  def source
    I18n.t("activerecord.enums.enquiry.source.#{object.source}")
  end

  def state
    I18n.t("activerecord.enums.enquiry.state.#{object.state}")
  end

  def created_at
    h.l object.created_at, format: :long
  end

  def updated_at
    h.l object.updated_at, format: :long
  end
end
