Dir["support/**/*.rb"].each {|f| require f }

if defined? RSpec
  RSpec.configure do |config|
    config.mock_with :rspec
  end
end

if defined? Spec
  Spec::Runner.configure do |config|
  end
end
