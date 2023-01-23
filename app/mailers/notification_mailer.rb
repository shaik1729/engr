class NotificationMailer < ApplicationMailer
    def new_notification
        @notification = params[:notification]

        if @notification.batch_id.present? && @notification.department_id.present? && @notification.regulation_id.present?
            @users = User.where(college_id: @notification.college_id, batch_id: @notification.batch_id, department_id: @notification.department_id, regulation_id: @notification.regulation_id)
        elsif @notification.batch_id.present? && @notification.department_id.present?
            @users = User.where(college_id: @notification.college_id, batch_id: @notification.batch_id, department_id: @notification.department_id)
        elsif @notification.batch_id.present? && @notification.regulation_id.present?
            @users = User.where(college_id: @notification.college_id, batch_id: @notification.batch_id, regulation_id: @notification.regulation_id)
        elsif @notification.department_id.present? && @notification.regulation_id.present?
            @users = User.where(college_id: @notification.college_id, department_id: @notification.department_id, regulation_id: @notification.regulation_id)
        elsif @notification.batch_id.present?
            @users = User.where(college_id: @notification.college_id, batch_id: @notification.batch_id)
        elsif @notification.department_id.present?
            @users = User.where(college_id: @notification.college_id, department_id: @notification.department_id)
        elsif @notification.regulation_id.present?
            @users = User.where(college_id: @notification.college_id, regulation_id: @notification.regulation_id)
        else
            @users = User.where(college_id: @notification.college_id)
        end

        mail(to: @users.pluck(:email), subject: @notification.title)
    end
end
