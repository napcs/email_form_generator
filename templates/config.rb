c = YAML::load(File.open("#{RAILS_ROOT}/config/email.yml"))

if c[RAILS_ENV]['email']['delivery_method'] == "sendmail"
   ActionMailer::Base.delivery_method = :sendmail

elsif c[RAILS_ENV]['email']['delivery_method'] == "test"
      ActionMailer::Base.delivery_method = :test
else
  ActionMailer::Base.delivery_method = :smtp


  ActionMailer::Base.smtp_settings[:tls] = true   
  
  ActionMailer::Base.smtp_settings = {
    :address  => c[RAILS_ENV]['email']['server'], 
    :port  => c[RAILS_ENV]['email']['port'], 
    :domain  => c[RAILS_ENV]['email']['domain'],
    :authentication => c[RAILS_ENV]['email']['authentication'],
    :user_name => c[RAILS_ENV]['email']['username'],
    :password => c[RAILS_ENV]['email']['password']
  }

end
WEB_HOST = c[RAILS_ENV]['email']['web_host']
CONTACT_RECIPIENT = c[RAILS_ENV]['email']['contact_recipient']