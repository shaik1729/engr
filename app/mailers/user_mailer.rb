class UserMailer < ApplicationMailer
    def welcome_user
        @name = params[:name]
        @email = params[:email]
        @password = params[:password]
        mail(to: @email, subject: "Your Account for ApnaCollege.co.in has been created successfully!!")
    end

    def user_creation_report
        @text_to_display = params[:text_to_display]
        @email = params[:email]
        mail(to: @email, subject: "User Creation Report")
    end
end
