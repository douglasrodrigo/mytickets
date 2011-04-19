# Load the rails application
require File.expand_path('../application', __FILE__)



# Initialize the rails application
Mytickets::Application.initialize!

Date::DATE_FORMATS[:default] = "%Y-%m-%d %H:%M"
Time::DATE_FORMATS[:default] = "%Y-%m-%d %H:%M"
Time::DATE_FORMATS[:pretty] = lambda { |time| time.strftime("%a, %b %e at %l:%M") + time.strftime("%p").downcase }

