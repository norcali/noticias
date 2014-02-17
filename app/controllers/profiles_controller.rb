class ProfilesController < ApplicationController
  before_filter :authenticate_user!

  def dashboard
    @user = User.find(current_user.id)
    if @user.role? :admin
      redirect_to admin_users_path, :notice => "Aloah Admin!"
    else
      render 'dashboard'
    end
  end

  def show
    @user = User.find(params[:user_id])
    render 'show'
  end

end