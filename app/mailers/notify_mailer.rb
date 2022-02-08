class NotifyMailer < ApplicationMailer
  def user_deadlines(email, events)
    @events = events
    mail(
      to: email,
      subject: I18n.t('emails.subjects.user_deadlines')
    )
  end
end