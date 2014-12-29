$LOAD_PATH << File.expand_path('../lib', __FILE__)

require 'rack/contrib/try_static'
require 'dubya'

use Rack::TryStatic, \
  root: 'public',
  files: ['/'],
  try: ['.html', 'index.html', '/index.html']

run Dubya
