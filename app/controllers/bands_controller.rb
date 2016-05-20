class BandsController < ApplicationController
  before_action :require_user
  before_action :set_band, only: [:edit, :update, :destroy]
  before_action :verify_membership, only: [:edit, :update, :destroy]
  before_action :verify_ownership, only: [:edit, :update, :destroy]

  def index
    if current_user
      @bands = current_user.bands.order('name ASC')
    else
      render 'application/welcome'
    end
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)
    @band.owner = current_user

    if @band.save
      @band.users << current_user
      flash[:success] = 'band was successfully created'
      redirect_to bands_path
    else
      render :new
    end
  end

  def edit
    @users = @band.order_users
  end

  def update
    if @band.update(band_params)
      flash[:success] = 'band was successfully updated'
      redirect_to edit_band_path
    else
      render :edit
    end
  end

  def destroy
    @band.destroy
    flash[:alert] = 'band was successfully deleted'
    redirect_to bands_url
  end

  private

  def set_band
    @band = Band.find(params[:id])
  end

  def band_params
    params.require(:band).permit(:name)
  end
end
