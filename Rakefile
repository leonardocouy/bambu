require "rake/testtask"

task default: :test

task :test do
  desc "Running tests..."
  Rake::TestTask.new do |t|
    t.libs << "test"
    t.options = "-v"
    t.test_files = FileList['tests/*_test.rb']
    t.verbose = true
  end
end
