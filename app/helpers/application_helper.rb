module ApplicationHelper
  def document_title
    if @title.present?
      "#{@title} - blog"
    else
      'blog'
    end
  end
end
