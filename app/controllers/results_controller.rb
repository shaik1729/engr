class ResultsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_result, only: %i[ show edit update destroy ]
  before_action :authorize, except: %i[ index ]
  
  # GET /results or /results.json
  def index
    @results = Result.where('college_id = ?', current_user.college_id)
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
        format.html { redirect_to result_url(@result), notice: "Result was successfully updated." }
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
      format.html { redirect_to results_url, notice: "Result was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def result_params
      params.require(:result).permit(:internal_marks, :external_marks, :total_marks, :result, :credits, :grade, :subject_id, :regulation_id, :batch_id, :semester_id, :user_id, :college_id)
    end

    def authorize
      if ['edit', 'update', 'destroy', 'show'].include?(params[:action])
        return raise Unauthorized unless @result.college.id == current_user.college.id
      elsif ['new', 'create'].include?(params[:action])
        return raise Unauthorized unless current_user.is_admin?
      end
    end
end
