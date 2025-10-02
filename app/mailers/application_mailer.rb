class ApplicationMailer < ActionMailer::Base
  # Usa tu correo de Gmail como el remitente por defecto para toda la aplicación
  default from: ENV["GMAIL_USERNAME"]
  layout "mailer"
end
