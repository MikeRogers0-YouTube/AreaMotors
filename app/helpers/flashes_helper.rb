module FlashesHelper
  # Render out all the flashes - this is a method I use in lots of projects
  # to keep my views logic free.
  def render_flashes
    return unless flash.any?
    content_tag :div, class: 'alerts container mt-4' do
      flash.collect do |key, value|
        content_tag :div, value, class: "alert alert-#{key}", role: :alert
      end.join('').html_safe
    end
  end
end
