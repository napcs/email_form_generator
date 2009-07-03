require File.dirname(__FILE__) + '/../test_helper'

class <%= controller_class_name %>ControllerTest < ActionController::TestCase

  def setup
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
    <%=class_name %>.any_instance.expects(:deliver).returns(true)
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
