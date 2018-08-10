module FlashesHelper
  # Render out all the flashes - this is a method I use in lots of projects
  # to keep my views logic free.
  def render_flashes
    return unless flash.any?
    content_tag :div, class: 'alerts container text-center border-bottom mt-4 mb-4' do
      flash.collect do |key, value|
        content_tag :p, value, class: "alerts__alert alerts--#{key}"
      end.join('').html_safe
    end
  end
end
