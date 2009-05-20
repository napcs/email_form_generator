class <%= class_name %> < Tableless
  <% for attribute in attributes -%>
  <%= "column :#{attribute.name}, :#{attribute.type}" %>
  <% end -%>
  
  
  def deliver
    if valid?
      begin
        <%= class_name %>Mailer::deliver_form(self)
      rescue
         @errors.add_to_base "Your message could not be sent due to configuration issues with the server."
         return false
      end
    else
      return false
    end
  end
  
  
end