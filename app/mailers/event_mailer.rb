class EventMailer < ApplicationMailer
  default from: 'dwellingk@gmail.com'

  def event_email
    @user = user
    mail(to: @user.email)
  end

end
