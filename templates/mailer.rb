class <%= class_name %>Mailer < ActionMailer::Base
  default_url_options[:host] = WEB_HOST
  
  def <%=singular_name %>(<%= file_name %>)
    setup_email(<%= file_name %>)
    @subject    += 'Message from the site'
    @recipients  = SITE_ADMIN_EMAIL
  end
  
  protected
    def setup_email(<%= file_name %>)
      @from        = "ADMINEMAIL"
      @subject     = "[YOURSITE]"
      @sent_on     = Time.now
      @body[:<%= file_name %>] = <%= file_name %>
    end
end
