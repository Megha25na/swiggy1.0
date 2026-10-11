require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "admin? helper" do
    assert users(:two).admin?
    assert_not users(:one).admin?
  end

  test "customer? helper" do
    assert users(:one).customer?
    assert_not users(:two).customer?
  end
end
