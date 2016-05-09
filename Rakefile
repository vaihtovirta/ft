require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubygems"

Bundler.setup

RSpec::Core::RakeTask.new(:spec)

task default: :spec

Dir["tasks/*.rake"].sort.each { |f| load f }
