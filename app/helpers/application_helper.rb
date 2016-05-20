module ApplicationHelper

  def welcome_page
    controller_name == 'bands' && action_name == 'index' && !current_user
  end

  def icon_add
    '<i class="fi-plus"></i>'.html_safe
  end

  def icon_back
    '<i class="fi-arrow-left"></i>'.html_safe
  end

  def icon_edit
    '<i class="fi-page-edit"></i>'.html_safe
  end

  def icon_torso
    '<i class="fi-torso"></i>'.html_safe
  end

  def icon_trash
    '<i class="fi-trash"></i>'.html_safe
  end

  def icon_x
    '<i class="fi-x"></i>'.html_safe
  end
end
