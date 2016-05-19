module ApplicationHelper

  def band_has_songs?
    @band.songs.count > 0
  end

  def welcome_page
    controller_name == 'bands' && action_name == 'index' && !current_user
  end

  def only_member?
    @band.users.count == 1
  end

  def song_has_attachments?
    @song.attachments.count > 0
  end

  def user_has_bands?
    @user.bands.count > 0
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

  def icon_torso
    '<i class="fi-torso"></i>'
  end

  def icon_trash
    '<i class="fi-trash"></i>'
  end
end
