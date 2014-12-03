# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Rails.application

use Rack::ReverseProxy do
  reverse_proxy /^\/blog(\/.*)$/, 'http://sqdupblog.flywheelsites.com$1', :username => ENV['WPBLOG_USERNAME'], :password => ENV['WPBLOG_PASSWORD'], :timeout => 500, :preserve_host => true
end