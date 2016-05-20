class MembershipsController < ApplicationController
  before_action :require_user
  before_action :set_band
  before_action :verify_membership

  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy

    if current_user.is_owner?(@band)
      flash[:alert] = 'successfully deleted member'
      redirect_to edit_band_path(@band)
    else
      flash[:alert] = 'successfully left band'
      redirect_to edit_user_path(current_user)
    end
  end

  private

  def set_band
    @band = Band.find(params[:band_id])
  end
end
