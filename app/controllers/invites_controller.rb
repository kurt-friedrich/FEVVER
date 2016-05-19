class InvitesController < ApplicationController
  before_action :set_band

  def new
    @invite = Invite.new
    @invite.band = @band
  end

  def create
    @invite = Invite.new(invite_params) # Make a new Invite
    @invite.sender_id = current_user.id # set the sender to the current user
    if @invite.save
      #if the user already exists
      if @invite.recipient != nil
        #send a notification email
        InviteMailer.existing_user_invite(@invite).deliver
        #Add the user to the user group
        @invite.recipient.bands.push(@invite.band)
      else
        InviteMailer.new_user_invite(@invite, signup_path(invite_token: @invite.token)).deliver
      end
      redirect_to edit_band_path(id: @band.id)
    else
      render :new
    end
  end

  private

  def set_band
    @band = Band.find(params[:band_id])
  end

  def set_invite
    @invite = Invite.find(params[:id])
  end

  def invite_params
    params.require(:invite).permit(:email, :band_id)
  end
end
