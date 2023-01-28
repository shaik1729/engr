class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_document, only: %i[ show edit update destroy ]
  before_action :authorize, except: %i[ index ]

  # GET /documents or /documents.json
  def index
    @q = Document.where(college_id: current_user.college_id).ransack(params[:q])
    if !params[:q].nil?
        @documents = @q.result(distinct: true).order(id: :desc).paginate(page: params[:page], per_page: 20)
        render 'search_results'
    end
    if !current_user.is_student?
      @documents = current_user.documents.all.order("id DESC")
    else
      @sem_wise_documents = Document.where(
        'college_id = ? and 
        regulation_id = ? and 
        department_id = ?', 
        current_user.college_id, 
        current_user.regulation_id, 
        current_user.department_id).group_by(&:semester_id).sort.to_h
    end
  end

  # GET /documents/1 or /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents or /documents.json
  def create
    @document = Document.new(document_params)

    @document.user_id = current_user.id
    @document.college_id = current_user.college_id

    respond_to do |format|
      if @document.save
        DocumentMailer.with(document: @document).added_document.deliver_later
        format.html { redirect_to documents_path, notice: "Document was successfully created." }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1 or /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to documents_path, notice: "Document was successfully updated." }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1 or /documents/1.json
  def destroy
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url, notice: "Document was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def document_params
      params.require(:document).permit(:title, :content, :file, :department_id, :regulation_id, :subject_id, :semester_id)
    end

    def authorize
      if ['edit', 'update', 'destroy', 'show'].include?(params[:action])
        return raise Unauthorized unless @document.user.id == current_user.id
      elsif ['new', 'create'].include?(params[:action])
        return raise Unauthorized unless !current_user.is_student?
      end
    end
end
