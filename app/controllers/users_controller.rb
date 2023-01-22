require 'creek'

class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: %i[ show edit update destroy ]
    before_action :authorize_admin

  
    def index
        @role_wise_users = User.where('college_id = ?', current_user.college_id).sort_by(&:id).reverse.group_by(&:role_id).to_h
        @roles = {
            '1' => 'Admin',
            '2' => 'Student',
            '3' => 'Faculty'
        }
        @batches = Batch.where('college_id = ?', current_user.college_id).group_by(&:id).to_h
        @regulations = Regulation.where('college_id = ?', current_user.college_id).group_by(&:id).to_h
        @departments = Department.where('college_id = ?', current_user.college_id).group_by(&:id).to_h
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

    def import
        begin
                
            workbook = Creek::Book.new params[:file].path
            worksheets = workbook.sheets

            skip_header = true

            if params[:role_id] == '2'

                worksheets.each do |worksheet|
                    worksheet.rows.each do |row|

                        if skip_header
                            skip_header = false
                            next
                        end

                        row_cells = row.values
                    
                        password = (0...8).map { (65 + rand(26)).chr }.join
                    
                        User.create!(
                            reg_no: row_cells[0], 
                            name: row_cells[1], 
                            email: row_cells[2], 
                            mobile_number: row_cells[3].to_i, 
                            password: password, 
                            password_confirmation: password, 
                            role_id: params[:role_id], 
                            college_id: params[:college_id], 
                            department_id: params[:department_id], 
                            batch_id: params[:batch_id], 
                            regulation_id: params[:regulation_id])
                
                    Rails.logger.info "Student User created: #{row_cells[0]} #{row_cells[1]} #{row_cells[2]} #{row_cells[3]} #{password} #{params[:role_id]} #{params[:college_id]} #{params[:department_id]} #{params[:batch_id]} #{params[:regulation_id]} "
                    end
                end
            else
                worksheets.each do |worksheet|
                    worksheet.rows.each do |row|

                        if skip_header
                            skip_header = false
                            next
                        end

                        row_cells = row.values

                        password = (0...8).map { (65 + rand(26)).chr }.join
                        
                        User.create!(
                            name: row_cells[0], 
                            email: row_cells[1], 
                            mobile_number: row_cells[2].to_i, 
                            password: password, 
                            password_confirmation: password, 
                            role_id: params[:role_id], 
                            college_id: params[:college_id], 
                            department_id: params[:department_id])
                        
                        Rails.logger.info "Faculty User created: #{row_cells[0]} #{row_cells[1]} #{row_cells[2]} #{password} #{params[:role_id]} #{params[:college_id]} #{params[:department_id]}"
                    end
                end
            end
        rescue => e
            Rails.logger.info "Error: #{e}"
            return redirect_to users_path, alert: "Error: #{e}"
        end
        return redirect_to users_path, notice: "Users imported successfully."
    end

  
    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :role_id, :college_id, :name, :reg_no, :mobile_number, :batch_id, :regulation_id, :department_id)
    end
  
    def authorize_admin
        if ['edit', 'update', 'destroy', 'show'].include?(params[:action])
          return raise Unauthorized unless (@user.college_id == current_user.college_id and current_user.is_admin?)
        elsif ['new', 'create', 'index'].include?(params[:action])
          return raise Unauthorized unless current_user.is_admin?
        end
    end
  end
  