class UsersController < ApplicationController

	def index
		@event = Event.all
		render '/layouts/homepage'
	end

	def show
		@user = User.find_by(id: params[:id])
		@badmintonsession = @user.events
	end

	def get_sign_in

	end

	def sign_in
		@user = User.find_by(email: params[:user][:email])
		if @user && @user.authenticate(params[:user][:password])
			if params[:user][:remember_me]
      			cookies.permanent[:auth_token] = @user.auth_token
    		else
      			cookies[:auth_token] = @user.auth_token
    		end
			redirect_to user_path(@user.id)
		else
			redirect_to root_path
		end 	
	end

	def sign_in_facebook(user)
		cookies[:auth_token] = user.auth_token
	end

	def sign_out
		cookies.delete(:auth_token)
		redirect_to root_path
	end

	def create
		@new_user = User.new(user_params)
		if @new_user.save
			if params[:user][:remember_me]
      			cookies.permanent[:auth_token] = @new_user.auth_token
    		else
      			cookies[:auth_token] = @new_user.auth_token
    		end
			redirect_to user_path(@new_user.id)
		else
			redirect_to root_path
		end
	end 

	def create_from_omniauth
		auth_hash = request.env["omniauth.auth"]
      	authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])

      # if: previously already logged in with OAuth
      
      if authentication != nil
        @user = authentication.user
        authentication.update_token(auth_hash)
        @next = "/", @notice = "Signed in!"
      # else: user logs in with OAuth for the first time
      elsif (@user = User.find_by(email: auth_hash['info']['email'])) != nil
        authentication = Authentication.create_with_omniauth(auth_hash)
        authentication.update(user_id: @user.id)
      else
        authentication = Authentication.create_with_omniauth(auth_hash)
        @user = User.create_with_auth_and_hash(authentication, auth_hash)
        # you are expected to have a path that leads to a page for editing user details
        #@next = edit_user_path(user)
        @notice = "User created. Please edit your details"
      end

      sign_in_facebook(@user)
      redirect_to user_path(@user.id), :info => @notice
    end

    def url_after_destroy
        "/"
    end 

    def edit
    	@user = User.find_by(id: params[:id])
    end

    def update
    	@profile = User.find_by(id: params[:id])
    	@user = User.find_by(id: params[:id])
    	@user.update(user_params)
    	redirect_to user_path(@profile.id)
    end

end

private

def user_params
	params.require(:user).permit(:first_name, :last_name, :email, :password, :phone, :address, :city, :postcode, :state, :auth_token)
end