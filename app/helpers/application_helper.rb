module ApplicationHelper


  def song_has_attachments?
    @song.attachments.count > 0
  end

  def user_is_owner?
    current_user == @band.owner
  end

  def icon_add
    '<i class="fi-plus"></i>'
  end

  def icon_back
    '<i class="fi-arrow-left"></i>'
  end

  def icon_edit
    '<i class="fi-page-edit"></i>'
  end
end
