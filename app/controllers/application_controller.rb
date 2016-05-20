class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def disallow_user
    if current_user
      flash[:info] = "you are already logged in"
      redirect_to :root
    end
  end

  def require_user
    unless current_user
      flash[:info] = "you must be logged in to do that"
      redirect_to :root
    end
  end

  def verify_membership
    unless @band.users.include?(current_user)
      flash[:alert] = "access denied - you are not a band member"
      redirect_to :root
    end
  end

  def verify_ownership
    unless current_user.is_owner?(@band)
      flash[:alert] = "access denied - you are not the band owner"
      redirect_to :root
    end
  end

  def verify_user
    unless current_user == @user
      flash[:alert] = "access denied - stop snooping around"
      redirect_to :root
    end
  end
end
