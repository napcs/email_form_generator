#=Tableless
#
# The Tableless model inherits from ActiveRecord::Base and then removes the
# database functionality from the model.
# 
#==Examples of use:
#
# class Foo < Tableless
#   column :bar, :string
#   validates_presense_of :bar
# end
#
# @foo = Foo.new
# @foo.save  #=> false
# @foo.bar = "hello"
# @foo.save #=> true
#
# This concept was inspired by Rick Olson
class Tableless < ActiveRecord::Base
  def self.columns() @columns ||= []; end
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default,
    sql_type.to_s, null)
  end
  
  # override the save method to prevent exceptions.
  def save(validate = true)
    validate ? valid? : true
  end
end
