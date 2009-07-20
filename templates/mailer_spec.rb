require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe <%=class_name %>Mailer do
  before(:each) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
  end
  
  it "should deliver <%=singular_name %>" do
    @f = <%=class_name %>.new
    
    <% attributes.each do |attribute| %>
       @f.<%=attribute.name %> = "foo"
    <% end %>
    
    <%=class_name%>Mailer::deliver_<%=singular_name %>(@f)
    ActionMailer::Base.deliveries.length.should == 1
    
  end
  
end