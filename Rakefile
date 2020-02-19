begin
  task :default => [:rspec, :rubocop]

  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:rspec)

  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:rubocop)
rescue LoadError
  # no rspec or rubocop available
end
