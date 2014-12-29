$LOAD_PATH << File.expand_path('../../', __FILE__)

require 'rspec'
require 'rack/test'
require 'dubya'

class Dubya < Sinatra::Base
  module TestHelp
    include Rack::Test::Methods

    def app
      Dubya
    end
  end
end

RSpec.configure do |config|
  config.include Dubya::TestHelp
end
