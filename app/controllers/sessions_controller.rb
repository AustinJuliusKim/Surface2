class SessionsController < ApplicationController
	def new
	end

 	 def create
 		 user = User.find_by(username: params[:login][:username])
 		 logger.debug(user)
  		if user && user.authenticate(params[:login][:password])
    			session[:user_id] = user.id.to_s
   			redirect_to users_path
  		else
  			flash.now[:error] = "The email or password you provided does not match our records"	
    			render :new
  		end
	end
	
	def destroy
		session.delete(:user_id)
		redirect_to login_path
	end

end
