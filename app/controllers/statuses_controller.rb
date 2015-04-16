class StatusesController < ApplicationController
	def create
		@user = User.find(params[:id])
		@status = @user.statuses.new(params.require(:status).permit(:body))
		@status.save
		redirect_to user_path(@user)
	end
end
