# Load the Rails application.
require File.expand_path('../application', __FILE__)
# Initialize the Rails application.
Rails.application.initialize!
#Formatting DateTime to look like "20/01/2011 10:28PM" 
Time::DATE_FORMATS[:default] = "%d/%m/%Y %l:%M%p"

Dir[File.join(Rails.root, "lib", "core_ext", "*.rb")].each {|l| require l }
