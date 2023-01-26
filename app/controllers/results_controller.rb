class ResultsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_result, only: %i[ show edit update destroy ]
  before_action :authorize, except: %i[ index ]
  
  # GET /results or /results.json
  def index
    if params[:search].present?
      @student = User.find_by(reg_no: params[:search].upcase!)
      if !@student.nil?
        @semester_wise_results = Result.where('user_id = ?', @student.id).group_by(&:semester_id).to_h
        if @semester_wise_results.empty?
          redirect_to results_path, notice: "Roll number doesn't have any resutls yet"
        end
      else
        redirect_to results_path, notice: "Roll number doesn't exist"
      end
    else
      if current_user.is_student?
        @semester_wise_results = Result.where('user_id = ?', current_user.id).group_by(&:semester_id).to_h
      else
        # @semester_wise_results = Result.where('college_id = ?', current_user.college_id).group_by(&:semester_id).to_h
        @semester_wise_results = {}
      end
    end
    @semesters = Semester.all.group_by(&:id).to_h
  end

  # GET /results/1 or /results/1.json
  def show
  end

  # GET /results/new
  def new
    @result = Result.new
  end

  # GET /results/1/edit
  def edit
  end

  # POST /results or /results.json
  def create
    @result = Result.new(result_params)

    @result.college_id = current_user.college_id

    if Result.exists?(user_id: @result.user_id, semester_id: @result.semester_id, subject_id: @result.subject_id)
      return redirect_to new_result_path, notice: "Result already exists"
    end

    respond_to do |format|
      if @result.save
        format.html { redirect_to new_result_path, notice: "Result was successfully created." }
        format.json { render :show, status: :created, location: @result }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /results/1 or /results/1.json
  def update
    respond_to do |format|
      if @result.update(result_params)
        format.html { redirect_to root_path, notice: "Result was successfully updated." }
        format.json { render :show, status: :ok, location: @result }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1 or /results/1.json
  def destroy
    @result.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Result was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def import
    begin
      if params[:file].nil? or params[:semester_id].blank?
        redirect_to root_path, notice: "Please select a file and semester" and return
      end

      if params[:file].content_type != "text/csv"
        redirect_to root_path, notice: "Please select a csv file" and return
      end

      text_to_display = ""

      records = CSV.parse(File.read(params[:file].path), headers: true)
      records.each do |student_record|

        @student = User.find_by(reg_no: student_record[0].upcase!)
        
        if @student.nil?
          text_to_display += "Student with roll number #{student_record[0]} doesn't exist \n"
          Rails.logger.info "Student with roll number #{student_record[0]} doesn't exist"
          next
        end

        arr_of_stu_record = student_record.to_a

        text_to_display += "Uploading result of : #{arr_of_stu_record[0][1]} \n"
        Rails.logger.info "Uploading result of : #{arr_of_stu_record[0]}"
        
        (1..arr_of_stu_record.length-1).step(6).each do |index| 

          if arr_of_stu_record[index].nil?
            next
          end

          @subject = Subject.find_by(college_id: @student.college.id, code: arr_of_stu_record[index][0])

          if @subject.nil?
            text_to_display += "#{arr_of_stu_record[index][0]} subject doesn't exist \n"
            Rails.logger.info "#{arr_of_stu_record[index][0]} subject doesn't exist"
            next
          end

          if Result.exists?(user_id: @student.id, subject_id: @subject.id, semester_id: params[:semester_id])
            text_to_display += "#{arr_of_stu_record[index][0]} subject result already exists \n"
            Rails.logger.info "#{arr_of_stu_record[index][0]} subject result already exists"
            next
          end

          @result = Result.new(
            user_id: @student.id,
            subject_id: @subject.id,
            result: arr_of_stu_record[index].last,
            internal_marks: arr_of_stu_record[index+1].last,
            external_marks: arr_of_stu_record[index+2].last,
            total_marks: arr_of_stu_record[index+3].last,
            credits: arr_of_stu_record[index+4].last,
            grade: arr_of_stu_record[index+5].last,
            regulation_id: @student.regulation_id,
            batch_id: @student.batch_id,
            semester_id: params[:semester_id],
            college_id: @student.college_id,
            department_id: @student.department_id
          )

          if @result.save
            text_to_display += "#{@subject.name} subject result Uploaded. \n"
            Rails.logger.info "#{arr_of_stu_record[index][0]} subject result Uploaded successfully."
          else
            text_to_display += "#{@subject.name} subject result Upload failed. \n"
            Rails.logger.info "#{arr_of_stu_record[index][0]} subject result Upload failed."
          end

        end
      end

      ResultMailer.with(email: current_user.email, text_to_display: text_to_display).result_creation_report.deliver_later
      redirect_to root_path, notice: "Result upload log sent to your email. #{current_user.email}" and return
    rescue => e
      redirect_to root_path, notice: "Error occured while uploading result. \n #{e}" and return
    end
  end
  
  def analysis
    @subject_wise_analysis = Result.where('college_id = ? and batch_id = ? and semester_id = ? and department_id = ?',current_user.college_id, params[:batch_id], params[:semester_id], params[:department_id]).group_by(&:subject_id).to_h
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def result_params
      params.require(:result).permit(:internal_marks, :external_marks, :total_marks, :result, :credits, :grade, :subject_id, :regulation_id, :batch_id, :semester_id, :user_id, :department_id)
    end

    def authorize
      if ['edit', 'update', 'destroy', 'show'].include?(params[:action])
        return raise Unauthorized unless @result.college.id == current_user.college.id and current_user.is_admin?
      elsif ['new', 'create', 'import', 'analysis'].include?(params[:action])
        return raise Unauthorized unless current_user.is_admin?
      end
    end
end
