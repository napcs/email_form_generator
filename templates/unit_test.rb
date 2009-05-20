require File.dirname(__FILE__) + '/../test_helper'

class <%= class_name %>Test < Test::Unit::TestCase

  def test_should_deliver_message
    
    @f = <%=class_name %>.new
    
    <% attributes.each do |attribute| %>
    @f.<%=attribute.name %> = "foo"
    <% end %>
    
    assert @f.deliver
  end
  
  # modify this test in such a way as to cause the 
  # validations to fail, if you have any.
  def test_should_not_deliver_message
    
    @f = <%=class_name %>.new
    assert ! @f.deliver
    
  end


end
