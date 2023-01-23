class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, only: %i[ show edit update destroy ]
  before_action :authorize, except: %i[ index ]

  # GET /notifications or /notifications.json
  def index
    @q = Notification.where(college_id: current_user.college_id).ransack(params[:q])
    if !params[:q].nil?
        @notifications = @q.result(distinct: true).order(id: :desc).paginate(page: params[:page], per_page: 20)
        render 'search_results'
    end
    @college_notifications = Notification.where('college_id = ? and by_admin = true', current_user.college_id).order(id: :desc).paginate(page: params[:page], per_page: 10)
    if current_user.is_faculty?
      @notifications = current_user.notifications.order(id: :desc).paginate(page: params[:page], per_page: 10)
    elsif current_user.is_student?
      @notifications = Notification.where(
        'college_id = ? and 
          batch_id = ? and 
          department_id = ? and 
          regulation_id = ? and 
          by_admin = false', current_user.college_id, 
                              current_user.batch_id, 
                              current_user.department_id, 
                              current_user.regulation_id).order(id: :desc).paginate(page: params[:page], per_page: 10)
    end
  end

  # GET /notifications/1 or /notifications/1.json
  def show
  end

  # GET /notifications/new
  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit
  end

  # POST /notifications or /notifications.json
  def create
    @notification = Notification.new(notification_params)

    @notification.user_id = current_user.id
    @notification.college_id = current_user.college_id

    if current_user.is_admin?
      @notification.by_admin = true
    end

    respond_to do |format|
      if @notification.save
        NotificationMailer.with(notification: @notification).new_notification.deliver_later
        format.html { redirect_to notifications_path, notice: "Notification was successfully created." }
        format.json { render :show, status: :created, location: @notification }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notifications/1 or /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to notifications_path, notice: "Notification was successfully updated." }
        format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1 or /notifications/1.json
  def destroy
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to notifications_url, notice: "Notification was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def notification_params
      params.require(:notification).permit(:title, :file, :department_id, :regulation_id, :batch_id)
    end
    
    def authorize
      if ['edit', 'update', 'destroy', 'show'].include?(params[:action])
        return raise Unauthorized unless @notification.user.id == current_user.id
      elsif ['new', 'create'].include?(params[:action])
        return raise Unauthorized unless !current_user.is_student?
      end
    end
end
