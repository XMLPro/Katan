class SessionsController < ApplicationController
  def new
  end

  def create

    user = User.create(name: params[:session][:name])
    if user
      login(user)
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    current_user.destroy
    log_out
    redirect_to login_url
  end
end
