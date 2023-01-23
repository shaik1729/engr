class ResultMailer < ApplicationMailer
    def result_creation_report
        @text_to_display = params[:text_to_display]
        @email = params[:email]
        mail(to: @email, subject: "Results Creation Report")
    end
end
