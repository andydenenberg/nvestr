module PostsHelper
  
  def type_color(type_is)
    color = 'label'
    if type_is == 'News'
      color = 'label label-info'
    elsif type_is == 'Discussion'
      color = 'label'
    end  
    return color
  end  
  
end
