class CommentsController < ApplicationController
  before_action :require_user
  before_action :set_band
  before_action :set_song
  before_action :verify_membership

  def create
    @comment = @song.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to band_song_path(@band, @song) }
        format.js {}
      else
        format.html { redirect_to band_song_path(@band, @song) }
      end
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
