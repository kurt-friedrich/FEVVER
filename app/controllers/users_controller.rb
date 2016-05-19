class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def new
    @user = User.new
    @token = params[:invite_token] #<-- pulls the value from the url query string
  end

  def create
    @user = User.new(user_params)
    @user.save
    @token = params[:invite_token]

    if @user.save
      session[:user_id] = @user.id
      if @token != nil
        org = Invite.find_by_token(@token).band #find the user group attached to the invite
        @user.bands.push(org) #add this user to the new user group as a member
        redirect_to root_path
      else
        redirect_to root_path, notice: 'User was successfully created.'
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update!(user_params)
        format.html { redirect_to edit_user_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :username, :password, :password_confirmation, :invite_token)
    end
end
