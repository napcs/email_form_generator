require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe <%= controller_class_name %>Controller do
  integrate_views
  
  it "should display the form" do
    get :new
    assigns(:<%= file_name %>).should_not be_nil
    response.should render_template(:new)
  end
  
  it "Should display the success page when an email is sent" do
    <%=class_name %>.any_instance.expects(:deliver).returns(true)
    post :create, {:<%= file_name %> => {}  }
    response.should render_template(:success)
  end

  it "should show the new page again" do
    <%=class_name %>.any_instance.expects(:deliver).returns(false)
    post :create
    response.should render_template(:new)
  end
end
