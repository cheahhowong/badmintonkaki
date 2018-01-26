class UsersController < ApplicationController

	def index
		render '/layouts/homepage'
	end

	def show

	end

	def get_sign_in

	end

	def sign_in
		@user = User.find_by(email: params[:user][:email])
		if @user && @user.authenticate(params[:user][:password])
			session[:user_id] = @user.id
			redirect_to '/users/show'
		else
			redirect_to root_path
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
			redirect_to '/users/show'
		else
			redirect_to root_path
		end
	end 

end

private
def user_params
	params.require(:user).permit(:first_name, :last_name, :email, :password, :phone, :address, :city, :postcode, :state)
end