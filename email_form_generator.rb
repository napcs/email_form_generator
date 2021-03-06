
require 'rails_commands'
class EmailFormGenerator < Rails::Generator::NamedBase
  default_options :skip_timestamps => false, :skip_migration => false
 
  attr_reader :controller_name,
                :controller_class_path,
                :controller_file_path,
                :controller_class_nesting,
                :controller_class_nesting_depth,
                :controller_class_name,
                :controller_underscore_name,
                :controller_singular_name,
                :controller_plural_name
  alias_method :controller_file_name, :controller_underscore_name
  alias_method :controller_table_name, :controller_plural_name
 
  def initialize(runtime_args, runtime_options = {})
    @original_name = ARGV[0]
    if ARGV[0]
      if ! ARGV[0].downcase.include?("form")
        ARGV[0] = ARGV[0].underscore + "_form"
      end
    end
    super
    
    @controller_name = @name.pluralize
 
    base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(@controller_name)
    @controller_class_name_without_nesting, @controller_underscore_name, @controller_plural_name = inflect_names(base_name)
    @controller_singular_name=base_name.singularize
    if @controller_class_nesting.empty?
      @controller_class_name = @controller_class_name_without_nesting
    else
      @controller_class_name = "#{@controller_class_nesting}::#{@controller_class_name_without_nesting}"
    end
  end
 
  def manifest
    recorded_session = record do |m|
      # Check for class naming collisions.
      m.class_collisions(controller_class_path, "#{controller_class_name}Controller", "#{controller_class_name}Helper")
      m.class_collisions(class_path, "#{class_name}")
 
      # Controller, helper, views, test and stylesheets directories.
      m.directory(File.join('app/models', class_path))
      m.directory(File.join('app/controllers', controller_class_path))
      m.directory(File.join('app/helpers', controller_class_path))
      m.directory(File.join('app/views', controller_class_path, controller_file_name))
      m.directory(File.join('app/views', controller_class_path, file_name + "_mailer"))
      m.directory(File.join('app/views/layouts', controller_class_path))

 
      for action in scaffold_views
      m.template(
          "view_#{action}.html.erb",
          File.join('app/views', controller_class_path, controller_file_name, "#{action}.html.erb")
        )
      end
     
      # mailer template
      m.template(
          "view_form.html.erb",
          File.join('app/views', controller_class_path, file_name + "_mailer", file_name + ".html.erb")
        )
        
        
      m.template(
        'controller.rb', File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb")
      )
      
      
      m.template(
        'tableless.rb', File.join('app/models', "tableless.rb"), :collision => :skip
      )
      m.template('config.yml', File.join('config', 'email.yml'), :collision => :skip)
      m.template('config.rb', File.join('config/initializers', 'email.rb'), :collision => :skip)
      
      m.template(
        'model.rb', File.join('app/models', "#{file_name}.rb")
      )
      
      m.template(
        'mailer.rb', File.join('app/models', "#{file_name}_mailer.rb")
      )
      
      unless options[:rspec]
        m.directory(File.join('test/functional', controller_class_path))
        m.directory(File.join('test/unit', class_path))
        m.template('functional_test.rb', File.join('test/functional', controller_class_path, "#{controller_file_name}_controller_test.rb"))
        m.template('mailer_test.rb', File.join('test/unit', "#{file_name}_mailer_test.rb"))
        m.template('unit_test.rb', File.join('test/unit', "#{file_name}_test.rb"))
        
      else
        m.directory(File.join('spec/controllers', controller_class_path))
        m.directory(File.join('spec/models', class_path))
        m.template('controller_spec.rb', File.join('spec/controllers', controller_class_path, "#{controller_file_name}_controller_spec.rb"))
        m.template('mailer_spec.rb', File.join('spec/models', "#{file_name}_mailer_spec.rb"))
        m.template('model_spec.rb', File.join('spec/models', "#{file_name}_spec.rb"))
      
      end
      
      m.route_resource  controller_singular_name
 
      action = nil
      action = $0.split("/")[1]
      case action
        when "generate"
          puts "Your form is ready for use in your application."
          puts "Before you start the server, fill in the right details into config/email.yml." 
          
      end      
      
    end
    
    recorded_session
     
  end
 
  protected
    
    def ran_before?
      (File.exist?('app/models/tableless.rb'))
    end
    
    # Override with your own usage banner.
    def banner
      "Usage: #{$0} email_form Contact [field:type, field:type]"
    end
 
    def add_options!(opt)
      opt.separator ''
      opt.separator 'Options:'
      opt.on("--spec", "Generate specs instead of test:unit files") {|v| options[:rspec] = v }
      opt.on("--skip-timestamps",
             "Don't add timestamps to the migration file for this model") { |v| options[:skip_timestamps] = v }
      opt.on("--skip-migration",
             "Don't generate a migration file for this model") { |v| options[:skip_migration] = v }
    end
 
    def scaffold_views
      %w[success new ]
    end
 
    def model_name
      class_name.demodulize
    end
end