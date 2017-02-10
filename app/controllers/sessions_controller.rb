class SessionsController < ApplicationController
  def create
    @registered_user = RegisteredUser.create(status: 1)
    @credential = @registered_user.pinspiration_credentials.create(credential_params)
    
    if @credential.save
      session[:registered_user_id] = @credential.registered_user.id
      redirect_to '#'
    else
      flash[:failure] = "User not saved. Please input information into each field and try again."
      redirect_to root_path
    end

  end

  def destroy
    session[:registered_user_id] = nil
    redirect_to root_path
  end

  private
    def credential_params
      params.require(:pinspiration_credential).permit(:name, :username, :email, :password, :phone_number)
    end
end
