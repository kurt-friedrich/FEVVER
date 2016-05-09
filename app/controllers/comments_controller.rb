class CommentsController < ApplicationController
  before_action :require_user
  before_action :set_song

  def index
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        @song.comments << @comment
        format.html { redirect_to band_song_path(id: @song.id) }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
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

  def set_song
    @song = Song.find(params[:song_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
