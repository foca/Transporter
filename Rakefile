require "rake/testtask"

begin
  require "hanna/rdoctask"
rescue LoadError
  require "rake/rdoctask"
end

Rake::RDocTask.new do |rd|
  rd.main = "README"
  rd.title = "API Documentation for Transporter"
  rd.rdoc_files.include("README.rdoc", "LICENSE", "lib/**/*.rb")
  rd.rdoc_dir = "doc"
end

begin
  require "mg"
  MG.new("transporter.gemspec")
rescue LoadError
end

Rake::TestTask.new

desc "Default: run tests"
task :default => :test
