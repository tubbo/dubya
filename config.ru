$LOAD_PATH << File.expand_path('../lib', __FILE__)

require 'rack/contrib/try_static'
require 'dubya'

use Rack::TryStatic, urls: ['/'], root: 'public', try: ['.html', 'index.html']
run Dubya::API
