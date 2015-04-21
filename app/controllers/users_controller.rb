class UsersController < ApplicationController
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
		@user = User.new(params.require(:user).permit(:username, :password , :first_name, :last_name, :email, :age, :gender, :looking_for))
		if @user.save
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
		#params.require(:user).permit(:username, :password, :first_name, :last_name, :email, :age, :gender, :looking_for))
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

	def user_params
		params.require(:user).permit(:username, :password, :first_name, :last_name, :email, :age, :gender, :looking_for)
	end
end
