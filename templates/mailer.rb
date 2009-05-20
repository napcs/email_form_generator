class <%= class_name %>Mailer < ActionMailer::Base
  def form(<%= file_name %>)
    setup_email(<%= file_name %>)
    @subject    += 'Message from the site'
    @recipients  = CONTACT_RECIPIENT

  end
  

  
  protected
    def setup_email(<%= file_name %>)
      @from        = "ADMINEMAIL"
      @subject     = "[YOURSITE] "
      @sent_on     = Time.now
      @body[:<%= file_name %>] = <%= file_name %>
    end
end
