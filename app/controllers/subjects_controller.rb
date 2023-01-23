class SubjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subject, only: %i[ show edit update destroy ]
  before_action :authorize_admin

  # GET /subjects or /subjects.json
  def index
    @subjects = current_user.college.subjects.order('id DESC').paginate(page: params[:page], per_page: 10)
  end

  # GET /subjects/1 or /subjects/1.json
  def show
  end

  # GET /subjects/new
  def new
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit
  end

  # POST /subjects or /subjects.json
  def create
    @subject = Subject.new(subject_params)

    @subject.college_id = current_user.college_id

    if Subject.exists?(name: @subject.name.upcase, code: @subject.code.upcase, regulation_id: @subject.regulation_id, college_id: @subject.college_id)
      return redirect_to subjects_url, notice: "Subject already exists."
    end

    respond_to do |format|
      if @subject.save
        format.html { redirect_to subjects_path, notice: "Subject was successfully created." }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1 or /subjects/1.json
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to subjects_path, notice: "Subject was successfully updated." }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1 or /subjects/1.json
  def destroy
    @subject.destroy

    respond_to do |format|
      format.html { redirect_to subjects_url, notice: "Subject was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subject_params
      params.require(:subject).permit(:name, :code, :regulation_id)
    end

    def authorize_admin
      if ['edit', 'update', 'destroy', 'show'].include?(params[:action])
        return raise Unauthorized unless @subject.college_id == current_user.college_id and current_user.is_admin?
      elsif ['new', 'create', 'index'].include?(params[:action])
        return raise Unauthorized unless current_user.is_admin?
      end
    end

end
