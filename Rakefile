require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

begin
  require 'rubocop/rake_task'
  Rubocop::RakeTask.new
rescue LoadError
  desc 'Run RuboCop'
  task :rubocop do
    $stderr.puts 'Rubocop is disabled'
  end
end

task default: [:spec, :rubocop]
