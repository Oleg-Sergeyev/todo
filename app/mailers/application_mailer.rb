# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'info@dvpweb.ru'
  layout 'mailer'
end
