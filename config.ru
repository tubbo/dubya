$LOAD_PATH << File.expand_path('../lib', __FILE__)

require 'dubya'

use Rack::Auth::Basic, "wiki" do |username, password|
  username == Dubya.username && password == Dubya.password
end
use Rack::Static, urls: %w(/assets), root: 'public'
run Dubya::API
