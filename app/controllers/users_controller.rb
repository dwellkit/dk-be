class UsersController < ApplicationController
  before_action :authenticate_user_from_token!

  def show
    @user = current_user
    @properties = current_user.properties
    if @user
      render "user/show.json.jbuilder", status: :ok
    end
  end
end
