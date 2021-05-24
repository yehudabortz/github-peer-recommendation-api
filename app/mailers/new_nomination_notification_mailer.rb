class NewNominationNotificationMailer < ApplicationMailer
        default :from => ENV['FROM_EMAIL_ADDRESS']

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_notifiaction_email(user, link="")
    @user = user
    @link = link
    mail( :to => ENV['FROM_EMAIL_ADDRESS'],
    :subject => "@#{@user.linkedin_handle} Was Just Nominated" )
  end
end
