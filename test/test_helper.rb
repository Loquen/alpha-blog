ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  # Helper to sign in user. Password must be string not user.password b/c of hash
  def sign_in_as(user, password)
    post login_path, session: {email: user.email, password: password}
  end
  
  # Helper to sign up new users. Password must be string not user.password b/c of hash
  def sign_up_new(user, password)
    post signup_path, session: {username: user.name, email: user.email, password: password} # Need to confirm that this is the apropriate way to login
  end
end
