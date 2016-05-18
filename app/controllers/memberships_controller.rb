class MembershipsController < ApplicationController
  before_action :require_user
  before_action :set_band

  def new
  end

  def create
    @band.users << @user

    respond_to do |format|
      if @membership.save
        format.html { redirect_to band_song_path(id: @song.id) }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to edit_band_path(@band) }
      format.json { head :no_content }
    end
  end

  private

  def set_band
    @band = Band.find(params[:band_id])
  end
end
