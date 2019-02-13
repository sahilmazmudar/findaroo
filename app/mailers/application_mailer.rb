class ApplicationMailer < ActionMailer::Base
	default from: 'mailgun@sandbox15a007ae7e244d4783ea0a3dc1aa9369.mailgun.org'
	layout 'mailer'
end
