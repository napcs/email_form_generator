require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe <%= class_name %> do

  it "should deliver the message" do
    
    @f = <%=class_name %>.new
    
    <% attributes.each do |attribute| %>
    @f.<%=attribute.name %> = "foo"
    <% end %>
    
    @f.deliver.should == true
  end
  
  # modify this test in such a way as to cause the 
  # validations to fail, if you have any.
  # it "should not deliver the message when there are errors" do
  #   
  #   @f = <%=class_name %>.new
  #   @f.deliver.should_not == true
  #   
  # end


end
