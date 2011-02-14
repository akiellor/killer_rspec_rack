require 'rubygems'
require 'rake'
require 'rake/gempackagetask'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new :spec do |t|
  t.rspec_opts= '--color'
end

spec = Gem::Specification.new do |s|
  s.author = 'Andrew Kiellor'
  s.email = 'akiellor@gmail.com'
  s.summary = "RSpec macros and matchers for testing Rack apps."
  s.description =
  """
    A collection of RSpec macros and matchers for testing
    Rack based Ruby applications apps.
  """
  s.homepage = 'http://github.com/akiellor/killer_rspec_rack'
  s.platform = Gem::Platform::RUBY
  s.name = 'killer_rspec_rack'
  s.version = '0.0.2.trunk'
  s.requirements << 'rspec v1.3, or greater'
  s.require_path = 'lib'
  s.files = ['lib/killer_rspec_rack.rb',
             'lib/killer_rspec_rack/macros.rb',
             'lib/killer_rspec_rack/matchers.rb']
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end

task :default => :spec
