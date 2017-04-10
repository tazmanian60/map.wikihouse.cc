module ApplicationHelper
  def markdown(text)
    Loofah.scrub_fragment(Kramdown::Document.new(text.to_s).to_html, :strip)
          .to_s
          .html_safe
  end

  def render_place(place)
    presenter = Object.const_get("#{place.class.name}Presenter")

    content_tag(
      :div,
      render(
        partial: "places/#{place.class.name.underscore}",
        formats: [:html],
        object: presenter.new(place, controller.view_context)
      ),
      class: "place #{place.class.name}"
    )
  end
end
