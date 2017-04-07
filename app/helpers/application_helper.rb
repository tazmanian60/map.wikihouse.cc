module ApplicationHelper
  def markdown(text)
    Loofah.scrub_fragment(Kramdown::Document.new(text).to_html, :strip)
          .to_s
          .html_safe
  end

  def render_place(place)
    presenter = Object.const_get("#{place.class.name}Presenter")

    render(
      partial: "places/#{place.class.name.underscore}",
      formats: [:html],
      object: presenter.new(place, controller.view_context)
    )
  end
end
