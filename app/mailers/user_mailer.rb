class UserMailer < ApplicationMailer
    def welcome_user
        @name = params[:name]
        @email = params[:email]
        @password = params[:password]
        mail(to: @email, subject: "Your Account for ApnaCollege.co.in has been created successfully!!")
    end
end
