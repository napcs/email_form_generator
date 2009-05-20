require File.dirname(__FILE__) + '/../test_helper'
require '<%= controller_file_name %>_controller'

# requires mocha gem - gem install mocha
require 'mocha'

# Re-raise errors caught by the controller.
class <%= controller_class_name %>Controller; def rescue_action(e) raise e end; end

class <%= controller_class_name %>ControllerTest < Test::Unit::TestCase



  def setup
    @controller = <%= controller_class_name %>Controller.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = false
    ActionMailer::Base.deliveries = []
    
  end

  def test_should_display_form
    get :new
    assert_not_nil assigns(:<%= file_name %>)
    assert_response :success
  end
  
  
  def test_should_show_success_when_created
    post :create, {:<%= file_name %> => {}  }
    assert_response :success
    assert_template "success"
  end

  def test_should_fail_to_send_and_show_form_again
    <%=class_name %>.any_instance.expects(:deliver).returns(false)
    
    post :create
    assert_response :success
    assert_template "new"
  end

 
end
