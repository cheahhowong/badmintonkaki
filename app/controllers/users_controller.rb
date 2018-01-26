class UsersController < ApplicationController

	def show

	end

	def sign_in
		@user = User.find_by(email: params[:email])
		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect_to root_path
		else
			
		end 	
	end

	def sign_out
		session.clear
		redirect_to root_path
	end

	def create
		@new_user = User.new(user_params)
		if @new_user.save
			session[:user_id] = @new_user.id
			redirect_to root_path
		else

		end
	end 

end

private
def user_params
	params.require(:user).permit(:first_name, :last_name, :email, :password, :phone, :address, :city, :postcode, :state, {verification_documents: []}, :affiliates_avatar)
end