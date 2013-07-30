# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Jkscience::Application.initialize!

ActionMailer::Base.smtp_settings = {

  :enable_starttls_auto => true,
  
  :address => "smtp.gmail.com",
  
  :port => 587,
  
  :domain => "mydomain.com",
  
  :authentication => :plain,
  
  :user_name => "",
  
  :password => ""
  
}
