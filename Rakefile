require 'rake/testtask'

task default: :test

require 'simplecov'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/*_test.rb'
end

task :pronto do
  require 'pronto'

  Pronto::GemNames.new.to_a.each { |gem_name| require "pronto/#{gem_name}" }

  class Pronto::Formatter::GithubStatusFormatter::StatusBuilder
    DEFAULT_LEVEL_TO_STATE_MAPPING = {
      info: :failure, warning: :failure, error: :failure, fatal: :failure
    }.freeze
  end

  system "bundle exec pronto run -f github_pr github_status -c #{ENV["TRAVIS_PULL_REQUEST_BRANCH"]}"
  # status_formatter = Pronto::Formatter::GithubStatusFormatter.new
  # pr_formatter = Pronto::Formatter::GithubPullRequestFormatter.new
  # formatters = [status_formatter, pr_formatter]
  # Pronto.run("master", '.', formatters)
end

