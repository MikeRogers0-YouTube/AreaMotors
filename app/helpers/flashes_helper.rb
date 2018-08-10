module FlashesHelper
  # Render out all the flashes - this is a method I use in lots of projects
  # to keep my views logic free.
  def render_flashes
    return unless flash.any?
    content_tag :div, class: 'alerts' do
      flash.collect do |key, value|
        content_tag :p, value, class: "alerts alerts--#{key}"
      end.join('')
    end
  end
end
