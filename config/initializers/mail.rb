# frozen_string_literal: true

if ENV['SMTP_USER']
  Mail.defaults do
    delivery_method :smtp,
      port: 587,
      address: 'smtp.' + ENV.fetch('SMTP_USER').split('@').last,
      domain: ENV.fetch('SMTP_USER').split('@').last,
      user_name: ENV.fetch('SMTP_USER'),
      password: ENV.fetch('SMTP_PASSWORD'),
      authentication: 'plain',
      enable_starttls_auto: true
  end
end
