class CommentsController < ApplicationController
  before_action :require_user
  before_action :set_band
  before_action :set_song

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    if @comment.save
      @song.comments << @comment
      redirect_to band_song_path(@band, @song)
    else
      redirect_to band_song_path(@band, @song)
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to band_song_path }
      format.json { head :no_content }
    end
  end

  private

  def set_band
    @band = Band.find(params[:band_id])
  end

  def set_song
    @song = Song.find(params[:song_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
