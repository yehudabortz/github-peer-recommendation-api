class UserInviteMailer < ApplicationMailer
    default :from => ENV['FROM_EMAIL_ADDRESS']

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user, link="")
    @user = user
    @link = link
    mail( :to => @user.email,
    :subject => "You've Been Nominated" )
  end
end
