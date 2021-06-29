class UserMailer < ActionMailer::Base
    default :from => "someone@test.com"
    
    def notification_confirmation(user, group)
      @user = user
      @group = group 
    #   attachments["images.png"] = File.read("#{Rails.root}/public/images/images.png")
      mail(:to => "#{@user.first_name} <#{@user.email}>", :subject => "Notification from group ")
    end
  end