class BatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_batch, only: %i[ show edit update destroy ]
  before_action :authorize_admin

  # GET /batches or /batches.json
  def index
    @batches = current_user.college.batches.order(id: :desc).paginate(page: params[:page], per_page: 10)
  end

  # GET /batches/1 or /batches/1.json
  def show
  end

  # GET /batches/new
  def new
    @batch = Batch.new
  end

  # GET /batches/1/edit
  def edit
  end

  # POST /batches or /batches.json
  def create
    @batch = Batch.new(batch_params)

    @batch.college_id = current_user.college_id

    if Batch.exists?(year: @batch.year, college_id: @batch.college_id)
      return redirect_to batches_url, notice: "Batch already exists."
    end

    respond_to do |format|
      if @batch.save
        format.html { redirect_to batches_url, notice: "Batch was successfully created." }
        format.json { render :show, status: :created, location: @batch }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /batches/1 or /batches/1.json
  def update
    respond_to do |format|
      if @batch.update(batch_params)
        format.html { redirect_to batches_url, notice: "Batch was successfully updated." }
        format.json { render :show, status: :ok, location: @batch }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /batches/1 or /batches/1.json
  def destroy
    @batch.destroy

    respond_to do |format|
      format.html { redirect_to batches_url, notice: "Batch was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_batch
      @batch = Batch.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def batch_params
      params.require(:batch).permit(:year)
    end

    def authorize_admin
      if ['edit', 'update', 'destroy', 'show'].include?(params[:action])
        return raise Unauthorized unless @batch.college_id == current_user.college_id and current_user.is_admin?
      elsif ['new', 'create', 'index'].include?(params[:action])
        return raise Unauthorized unless current_user.is_admin?
      end
    end
end
