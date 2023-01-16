class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin, only: :create
  
    def create
        @user = User.new(user_params)

        respond_to do |format|
            if @user.save
                format.html { redirect_to root_path, notice: "User was successfully created." }
                format.json { render :show, status: :created, location: @User }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end
  
    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :role_id, :college_id)
    end
  
    def authorize_admin
      return unless !current_user.is_admin?
      redirect_to root_path, alert: 'Admins only!'
    end
  end
  