# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

# The basic idea is to save the temporary uploaded files in ./tmp/uploads/ and to tell Rack via Rack::Static to serve any
# requests coming in for /uploads from ./tmp/uploads.
# use Rack::Static, :urls => ['/uploads'], :root => 'tmp'

run FirstApp::Application
