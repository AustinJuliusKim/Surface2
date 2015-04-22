class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :authorized?, only: [:edit, :update]

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		@status = Status.new
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			[session[:user_id] = @user.id.to_s]
			flash[:welcome] = "Thanks for signing up!"
			redirect_to users_path
		else
			render :new
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])

		if @user.update_attributes(user_params)
			redirect_to users_path
		else
			render :edit
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to users_path
	end
	private

	def require_login
		unless logged_in?
			flash[:error] = "You must be logged in to access that page."
			redirect_to login_path
		end
	end

	def authorized?
		unless current_user == User.find(params[:id])
			flash[:error] = "You are not authorized to access that page."
			redirect_to user_path
		end
	end

	def user_params
		params.require(:user).permit(:username, :password, :first_name, :last_name, :email, :age, :gender, :looking_for)
	end
end
