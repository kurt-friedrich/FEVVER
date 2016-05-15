module ApplicationHelper

  def user_is_owner?
    current_user == @band.owner
  end
end
