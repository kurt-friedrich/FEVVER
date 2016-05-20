class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]
  before_action :set_band

  def index
    @songs = @band.songs.order("created_at DESC")
  end

  def show
    @comment = Comment.new
    @comments = @song.comments
  end

  def new
    @song = Song.new
    @song.attachments.build
  end

  def create
    @song = @band.songs.new(song_params)

    if @song.save
      flash[:success] = 'song was successfully created'
      redirect_to band_songs_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @song.update(song_params)
      flash[:success] = 'song was successfully updated'
      redirect_to edit_band_song_path
    else
      render :edit
    end
  end

  def destroy
    @song.destroy
    flash[:alert] = 'song was successfully destroyed'
    redirect_to band_songs_path
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
