class <%= controller_class_name %>Controller < ApplicationController

 
# GET /<%= table_name %>/new
# GET /<%= table_name %>/new.xml
def new
@<%= file_name %> = <%= class_name %>.new
 
respond_to do |format|
format.html # new.html.erb
format.xml { render :xml => @<%= file_name %> }
end
end
 

# POST /<%= table_name %>
# POST /<%= table_name %>.xml
  def create
    @<%= file_name %> = <%= class_name %>.new(params[:<%= file_name %>])
 
respond_to do |format|
if @<%= file_name %>.deliver
        flash[:notice] = 'The message was sent successfully.'
        format.html { render :action=>"success" }
format.xml { render :xml => @<%= file_name %>, :status => :created, :location => @<%= file_name %> }
else
format.html { render :action => "new" }
        format.xml { render :xml => @<%= file_name %>.errors, :status => :unprocessable_entity }
      end
    end
  end
 
 
end