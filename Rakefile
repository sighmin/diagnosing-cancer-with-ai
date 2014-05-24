#!/usr/bin/env rake

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

task default: :spec

task :run do
  puts `bundle exec ruby bin/run`
end
