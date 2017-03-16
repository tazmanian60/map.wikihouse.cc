module AdminHelper
  def nav_link(state)
    class_name = "active" if @state == state

    content_tag(:li, class: class_name) do
      link_to(state.humanize, admin_places_path(state: state))
    end
  end

  EVENT_BUTTON_CLASSES = {
    "accept" => "btn-success",
    "reject" => "btn-danger",
  }

  def event_button_class(event)
    "btn #{EVENT_BUTTON_CLASSES.fetch(event)}"
  end
end
