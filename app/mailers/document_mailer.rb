class DocumentMailer < ApplicationMailer
    def added_document
        @document = params[:document]
        @users = User.where(college_id: @document.college_id, department_id: @document.department_id, regulation_id: @document.regulation_id)
        mail(to: @users.map(&:email).join(';'), subject: "#{@document.title} has been added")
    end
end
