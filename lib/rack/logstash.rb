require 'logger'
require 'json'
require 'rack/body_proxy'
require 'rack/logstash/version'

module Rack::Logstash
  autoload :Logger, 'rack/logstash/logger'
end
