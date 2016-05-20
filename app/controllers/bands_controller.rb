class BandsController < ApplicationController
  before_action :set_band, only: [:edit, :update, :destroy]
  before_action :set_user

  def index
    if current_user
      @bands = @user.bands.order('name ASC')
    else
      render 'application/welcome'
    end
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)
    @band.owner = @user

    if @band.save
      @band.users << @user
      flash[:success] = 'Band was successfully created'
      redirect_to bands_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @band.update(band_params)
      flash[:alert] = 'Band was successfully updated'
      redirect_to bands_path
    else
      render :edit
    end
  end

  def destroy
    @band.destroy
    flash[:alert] = 'Band was successfully deleted'
    redirect_to bands_url
  end

  private

  def set_band
    @band = Band.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def band_params
    params.require(:band).permit(:name)
  end
end
