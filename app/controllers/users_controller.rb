class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: %i[ show edit update destroy ]
    before_action :authorize_admin

  
    def index
        @users = User.order('id DESC').where('college_id = ?', current_user.college_id)
    end

    def show
    end

    def new
        @user = User.new
    end

    def edit
    end

    def create
        @user = User.new(user_params)

        respond_to do |format|
            if @user.save
                format.html { redirect_to users_path, notice: "User was successfully created." }
                format.json { render :show, status: :created, location: @User }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
            if @user.update(user_params)
                format.html { redirect_to users_path, notice: "User was successfully updated." }
                format.json { render :show, status: :ok, location: @user }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @user.destroy
        respond_to do |format|
            format.html { redirect_to users_path, notice: "User was successfully destroyed." }
            format.json { head :no_content }
        end
    end

  
    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :role_id, :college_id, :name, :reg_no, :mobile_number, :batch_id, :regulation_id, :department_id, :avatar)
    end
  
    def authorize_admin
        if ['edit', 'update', 'destroy', 'show'].include?(params[:action])
          return raise Unauthorized unless @user.college_id == current_user.college_id
        elsif ['new', 'create', 'index'].include?(params[:action])
          return raise Unauthorized unless current_user.is_admin?
        end
    end
  end
  