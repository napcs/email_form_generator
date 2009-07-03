require File.dirname(__FILE__) + '/../test_helper'
require '<%= file_name %>_mailer'

class <%= class_name %>MailerTest < Test::Unit::TestCase


  def setup
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []


  end

  def test_deliver_<%=singular_name %>
    @f = <%=class_name %>.new
    
    <% attributes.each do |attribute| %>
       @f.<%=attribute.name %> = "foo"
    <% end %>
    
    <%=class_name%>Mailer::deliver_<%=singular_name %>(@f)
    assert_equal 1, ActionMailer::Base.deliveries.length
    
  end


end
