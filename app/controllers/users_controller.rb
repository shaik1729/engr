require 'creek'

class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: %i[ show edit update destroy ]
    before_action :authorize_admin
  
    def index
        @q = User.where(college_id: current_user.college_id).ransack(params[:q])
        if !params[:q].nil?
            @users = @q.result(distinct: true).paginate(page: params[:page], per_page: 20)
            render 'search_results'
        end
        @students = User.where('college_id = ? AND role_id = ?', current_user.college_id, 3).order(id: :desc).paginate(page: params[:page], per_page: 20)
        @faculties = User.where('college_id = ? AND role_id = ?', current_user.college_id, 2).order(id: :desc).paginate(page: params[:page], per_page: 10)
        @admins = User.where('college_id = ? AND role_id = ?', current_user.college_id, 1).order(id: :desc).paginate(page: params[:page], per_page: 10)
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

        @user.college_id = current_user.college_id

        respond_to do |format|
            if @user.save
                UserMailer.with(name: @user.name, email: @user.email, password: @user.password).welcome_user.deliver_later
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
            if params[:file].nil? or params[:role_id].nil? or params[:department_id].nil?
                return redirect_to new_user_path, notice: "Please select a file role and department"
            elsif params[:role_id] == '2' and (params[:batch_id].nil? or params[:regulation_id].nil?)
                return redirect_to new_user_path, notice: "Please select a batch and regulation"
            elsif params[:file].content_type != 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
                return redirect_to new_user_path, notice: "Please select a valid file"
            end
                
            workbook = Creek::Book.new params[:file].path
            worksheets = workbook.sheets

            skip_header = true

            text_to_display = ''

            if Role.find(params[:role_id]).is_student?

                worksheets.each do |worksheet|
                    worksheet.rows.each do |row|

                        if skip_header
                            skip_header = false
                            next
                        end

                        if row.values[0].nil?
                            next
                        end

                        row_cells = row.values
                    
                        password = (0...8).map { (65 + rand(26)).chr }.join

                        if User.exists?(reg_no: row_cells[0].upcase)
                            text_to_display += "#{row_cells[0]} User already exists\n"
                            Rails.logger.info "#{row_cells[0]} User already exists"
                            next
                        end
                    
                        @user = User.new(
                            reg_no: row_cells[0], 
                            name: row_cells[1], 
                            email: row_cells[2], 
                            mobile_number: row_cells[3].to_i, 
                            password: password, 
                            password_confirmation: password, 
                            role_id: params[:role_id], 
                            college_id: current_user.college_id, 
                            department_id: params[:department_id], 
                            batch_id: params[:batch_id], 
                            regulation_id: params[:regulation_id])

                        if @user.save
                            text_to_display += "#{@user.reg_no} -> #{@user.password} created successfully. \n"
                            UserMailer.with(name: @user.name, email: @user.email, password: password).welcome_user.deliver_later
                            Rails.logger.info "Student User created: #{row_cells[0]} #{row_cells[1]} #{row_cells[2]} #{row_cells[3]} #{password} #{params[:role_id]} #{current_user.college_id} #{params[:department_id]} #{params[:batch_id]} #{params[:regulation_id]} "
                        else
                            text_to_display += "#{row_cells[0]} creation failed. \n"
                            Rails.logger.info "Student User creation failed: #{row_cells[0]} #{row_cells[1]} #{row_cells[2]} #{row_cells[3]} #{password} #{params[:role_id]} #{current_user.college_id} #{params[:department_id]} #{params[:batch_id]} #{params[:regulation_id]} "
                        end
                
                    end
                end
            else
                worksheets.each do |worksheet|
                    worksheet.rows.each do |row|

                        if skip_header
                            skip_header = false
                            next
                        end

                        if row.values[0].nil?
                            next
                        end

                        row_cells = row.values

                        password = (0...8).map { (65 + rand(26)).chr }.join

                        if User.exists?(email: row_cells[1].downcase)
                            text_to_display += "#{row_cells[1]} User already exists\n"
                            Rails.logger.info "#{row_cells[1]} User already exists"
                            next
                        end
                        
                        @user = User.new(
                            name: row_cells[0], 
                            email: row_cells[1], 
                            mobile_number: row_cells[2].to_i, 
                            password: password, 
                            password_confirmation: password, 
                            role_id: params[:role_id], 
                            college_id: current_user.college_id, 
                            department_id: params[:department_id])
                        
                        if @user.save
                            text_to_display += "#{@user.email} -> #{@user.password} created successfully. \n"
                            UserMailer.with(name: @user.name, email: @user.email, password: password).welcome_user.deliver_later
                            Rails.logger.info "Staff User created: #{row_cells[0]} #{row_cells[1]} #{row_cells[2]} #{password} #{params[:role_id]} #{current_user.college_id} #{params[:department_id]}"
                        else
                            text_to_display += "#{row_cells[1]} creation failed. \n"
                            Rails.logger.info "Staff User creation failed: #{row_cells[0]} #{row_cells[1]} #{row_cells[2]} #{password} #{params[:role_id]} #{current_user.college_id} #{params[:department_id]}"
                        end
                    end
                end
            end
            UserMailer.with(email: current_user.email, text_to_display: text_to_display).user_creation_report.deliver_later
            return redirect_to users_path, notice: "Users creation log sent to your email. #{current_user.email}"
        rescue => e
            Rails.logger.info "Error: #{e}"
            return redirect_to users_path, alert: "Error: #{e}"
        end
    end

  
    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :role_id, :name, :reg_no, :mobile_number, :batch_id, :regulation_id, :department_id)
    end
  
    def authorize_admin
        if ['edit', 'update', 'destroy', 'show'].include?(params[:action])
          return raise Unauthorized unless (@user.college_id == current_user.college_id and current_user.is_admin?)
        elsif ['new', 'create', 'index', 'import'].include?(params[:action])
          return raise Unauthorized unless current_user.is_admin?
        end
    end
  end
  