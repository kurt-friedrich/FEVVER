class SessionsController < ApplicationController
  before_action :disallow_user, only: [:new, :create]
  before_action :require_user, only: [:destroy]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to :root
    else
      flash[:alert] = "incorrect email / password combination"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
