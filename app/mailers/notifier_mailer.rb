class NotifierMailer < ApplicationMailer
	default from: 'mailgun@sandbox15a007ae7e244d4783ea0a3dc1aa9369.mailgun.org',
	return_path: 'system@example.com'

	def mailgun_send(matches)
		mg_client = Mailgun::Client.new '6c2e14be985c31aa1a12a95b10a5834c-1b65790d-d8a60bc4'

	    message_params = {:from    => "sahil.maz97@gmail.com",
	                      :to      => "sahil.mazmudar@alumni.ubc.ca",
	                      :subject => 'Findaroo - Your latest matches!',
	                      :text    => "Here are your latest matches: #{matches}"}
	    mg_client.send_message 'sandbox15a007ae7e244d4783ea0a3dc1aa9369.mailgun.org', message_params
	end
end
