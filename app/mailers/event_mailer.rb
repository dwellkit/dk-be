class EventMailer < ActionMailer::Base
  default from: 'dwellingk@gmail.com'

  def event_email(user)
    @user = user
    mail(to: @user.email)
  end

end
