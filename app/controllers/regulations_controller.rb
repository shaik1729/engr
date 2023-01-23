class RegulationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_regulation, only: %i[ show edit update destroy ]
  before_action :authorize_admin

  # GET /regulations or /regulations.json
  def index
    @regulations = current_user.regulations.all
  end

  # GET /regulations/1 or /regulations/1.json
  def show
  end

  # GET /regulations/new
  def new
    @regulation = Regulation.new
  end

  # GET /regulations/1/edit
  def edit
  end

  # POST /regulations or /regulations.json
  def create
    @regulation = Regulation.new(regulation_params)

    respond_to do |format|
      if @regulation.save
        format.html { redirect_to regulations_url, notice: "Regulation was successfully created." }
        format.json { render :show, status: :created, location: @regulation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @regulation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /regulations/1 or /regulations/1.json
  def update
    respond_to do |format|
      if @regulation.update(regulation_params)
        format.html { redirect_to regulations_url, notice: "Regulation was successfully updated." }
        format.json { render :show, status: :ok, location: @regulation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @regulation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regulations/1 or /regulations/1.json
  def destroy
    @regulation.destroy

    respond_to do |format|
      format.html { redirect_to regulations_url, notice: "Regulation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_regulation
      @regulation = Regulation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def regulation_params
      params.require(:regulation).permit(:name, :code, :user_id, :college_id)
    end

    def authorize_admin
      if ['edit', 'update', 'destroy', 'show'].include?(params[:action])
        return raise Unauthorized unless @regulation.user == current_user and current_user.is_admin?
      elsif ['new', 'create', 'index'].include?(params[:action])
        return raise Unauthorized unless current_user.is_admin?
      end
    end
end
