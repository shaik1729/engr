class DepartmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_department, only: %i[ show edit update destroy ]
  before_action :authorize_admin

  # GET /departments or /departments.json
  def index
    @departments = current_user.college.departments.order(id: :desc).paginate(page: params[:page], per_page: 10)
  end

  # GET /departments/1 or /departments/1.json
  def show
  end

  # GET /departments/new
  def new
    @department = Department.new
  end

  # GET /departments/1/edit
  def edit
  end

  # POST /departments or /departments.json
  def create
    @department = Department.new(department_params)

    @department.college_id = current_user.college_id

    if Department.exists?(name: @department.name.upcase, short_form: @department.short_form.upcase, college_id: @department.college_id)
      return redirect_to departments_url, notice: "Department already exists."
    end

    respond_to do |format|
      if @department.save
        format.html { redirect_to departments_url, notice: "Department was successfully created." }
        format.json { render :show, status: :created, location: @department }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1 or /departments/1.json
  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to departments_url, notice: "Department was successfully updated." }
        format.json { render :show, status: :ok, location: @department }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1 or /departments/1.json
  def destroy
    @department.destroy

    respond_to do |format|
      format.html { redirect_to departments_url, notice: "Department was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def department_params
      params.require(:department).permit(:name, :short_form, :code)
    end

    def authorize_admin
      if ['edit', 'update', 'destroy', 'show'].include?(params[:action])
        return raise Unauthorized unless @department.college_id == current_user.college_id and current_user.is_admin?
      elsif ['new', 'create', 'index'].include?(params[:action])
        return raise Unauthorized unless current_user.is_admin?
      end
    end
end
