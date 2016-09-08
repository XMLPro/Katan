class SessionsController < ApplicationController
  def new
  end

  def create

    user = User.create(name: params[:session][:name])
    if user
      login(user)
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
  end
end
