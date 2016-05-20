class InvitesController < ApplicationController
  before_action :set_band

  def new
    @invite = @band.invites.new
  end

  def create
    @invite = Invite.new(invite_params) # make a new Invite
    @invite.sender_id = current_user.id # set the sender to current user
    if @invite.save #if the user already exists
      if @invite.recipient != nil #send a notification email
        InviteMailer.existing_user_invite(@invite).deliver #add user to band
        @invite.recipient.bands.push(@invite.band)
      else #send invitiation email
        InviteMailer.new_user_invite(@invite, signup_path(invite_token: @invite.token)).deliver
      end
      flash[:success] = 'invite was successfully sent'
      redirect_to edit_band_path(@band)
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
