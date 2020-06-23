class ApplicationController < ActionController::Base
  before_action :ensure_user_login

  def ensure_user_login
    unless current_user
      redirect_to "/"
    end
  end

  def ensure_owner
    unless @current_user.is_owner
      redirect_to "/"
    end
  end

  def ensure_owner_or_clerk
    unless @current_user.is_owner or @current_user.is_clerk
      redirect_to "/"
    end
  end

  def current_user
    return @current_user if @current_user
    current_user_id = session[:current_user_id]
    if current_user_id
      @current_user = User.find(current_user_id)
    else
      nil
    end
  end
end
