class BandsController < ApplicationController
  before_action :set_band, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  def index
    @bands = @user.bands
  end

  def show
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)
    @band.users << @user

    respond_to do |format|
      if @band.save
        format.html { redirect_to bands_path, notice: 'Band was successfully created.' }
        format.json { render :show, rastatus: :created, location: @band }
      else
        format.html { render :new }
        format.json { render json: @band.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @band.update(band_params)
        format.html { redirect_to @band, notice: 'Band was successfully updated.' }
        format.json { render :show, status: :ok, location: @band }
      else
        format.html { render :edit }
        format.json { render json: @band.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @band.destroy
    respond_to do |format|
      format.html { redirect_to bands_url, notice: 'Band was successfully destroyed.' }
      format.json { head :no_content }
    end
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
