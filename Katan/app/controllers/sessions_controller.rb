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
    log_out
    user.destroy
    redirect_to login_url
  end
end
