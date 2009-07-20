# -*- ruby -*-





require 'rubygems'
require 'hoe'

class Hoe
  
  # remove dependency on Hoe
  def extra_deps
      @extra_deps.reject{|x| Array(x).first == 'hoe'}
  end
end

Hoe.new('email_form_generator', '1.0.5') do |p|
  p.rubyforge_name = 'emailform'
  p.name = "email_form_generator"
  p.author = 'Brian Hogan'
  p.email = 'info@napcs.com'
  p.summary = 'Email form generation with model, controller, tests, and mailer.'
  p.description = 'Generates a feedback form with model, controller, and views to make it dead simple for your users to send messages to you. '
  # p.url = p.paragraphs_of('README.txt', 0).first.split(/\n/)[1..-1]
  p.readme_file= "README.rdoc"
  p.extra_rdoc_files = FileList['*.rdoc']
  p.changes = p.paragraphs_of('History.txt', 0..1).join("\n\n")
  #p.need_tar = false
  #p.need_zip = false
  p.remote_rdoc_dir = ''
end

# vim: syntax=Ruby
