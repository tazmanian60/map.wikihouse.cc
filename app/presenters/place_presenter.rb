class PlacePresenter < Presenter
  def description
    h.markdown super
  end

  def link_list
    return unless links?

    h.content_tag(:ul,
      h.safe_join(
        super.map { |link| h.content_tag(:li, h.auto_link(link)) }
      )
    )
  end

  def image
    return unless image?

    h.content_tag(:p, h.image_tag(super.url(:normal)))
  end
end
