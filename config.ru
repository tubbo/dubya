$LOAD_PATH << File.expand_path('../lib', __FILE__)

require 'rack/contrib/try_static'
require 'dubya'

use Rack::Auth::Basic, "wiki" do |username, password|
  username == Dubya.username && password == Dubya.password
end
use Rack::TryStatic, urls: ['/'], root: 'public', try: ['.html', 'index.html']
run Dubya::API
