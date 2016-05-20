class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :verify_user, only: [:edit, :update, :destroy]

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
        flash[:success] = 'welcome to FEVVER'
        redirect_to root_path
      end
    else
      render :new
    end
  end

  def edit
    @bands = @user.order_bands
  end

  def update
    if @user.update!(user_params)
      flash[:success] = 'account info successfully updated'
      redirect_to edit_user_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to :root
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :username, :password, :password_confirmation, :invite_token)
    end
end
