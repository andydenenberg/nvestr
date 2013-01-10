module ApplicationHelper
  def active_view(view,mode)
    if view == mode
    "active"
    else
    ""
    end
  end
end
