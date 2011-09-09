require 'test_helper'

class FollowshipTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Followship.new.valid?
  end
end
