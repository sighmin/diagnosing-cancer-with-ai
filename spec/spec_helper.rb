require 'simplecov'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|file| require file}

require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'intelligence' # Don't forget this...

RSpec.configure do |config|

end

