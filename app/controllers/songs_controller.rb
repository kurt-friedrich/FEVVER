class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]
  before_action :set_band

  def index
    @songs = @band.songs.order("created_at DESC")
  end

  def show
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def new
    @song = Song.new
    @song.attachments.build
  end

  def create
    @song = @band.songs.new(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to band_songs_path, notice: 'Song was successfully created.' }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to band_song_path, notice: 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to band_songs_url, notice: 'Song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_song
      @song = Song.find(params[:id])
    end

    def set_band
      @band = Band.find(params[:band_id])
    end

    def song_params
      params.require(:song).permit(:name, :key, :lyrics, :note, :band_id, attachments_attributes: [:file])
    end
end
