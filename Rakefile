begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rspec/core/rake_task' rescue LoadError

if defined?(RSpec)
  desc "Run specs"
  RSpec::Core::RakeTask.new('spec') do |t|
    if seed = ENV['SEED']
      t.rspec_opts = "--seed #{seed}"
    end
  end
  task default: 'spec'
end