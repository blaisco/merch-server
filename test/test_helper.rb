ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
end

# provides sign_in() and sign_out() methods in controller tests
class ActionController::TestCase
  include Devise::TestHelpers
end
