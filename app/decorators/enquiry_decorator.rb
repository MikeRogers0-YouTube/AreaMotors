class EnquiryDecorator < Draper::Decorator
  delegate_all

  def message
    h.sanitize(object.message, tags: %w(br))
  end

  def listing_url
    h.link_to object.listing_url, object.listing_url, target: '_blank'
  end

  def source
    I18n.t("activerecord.enums.enquiry.sources.#{object.source}")
  end

  def state
    if state_custom?
      custom_state
    else
      I18n.t("activerecord.enums.enquiry.states.#{object.state}")
    end
  end

  def created_at
    h.l object.created_at, format: :long
  end

  def updated_at
    h.l object.updated_at, format: :long
  end

  def notes
    h.sanitize((object.notes).strip.gsub(/(?:\n\r?|\r\n?)/, '<br>'), tags: %w[br])
  end
end
