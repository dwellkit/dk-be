class RegistrationsController < Devise::RegistrationsController
  def create 
    if params[:user][:password] != params[:user][:password_confirmation]
      render json: { :error => "Passwords do not match" }, status: :bad_request
      return false
    end
    @user = User.new(user_params)
    if @user.save
      render json: { :user => @user }, status: :created
    else
      render json: { :messages => @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private 
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end