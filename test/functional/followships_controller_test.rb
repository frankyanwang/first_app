require 'test_helper'

class FollowshipsControllerTest < ActionController::TestCase
  def test_create_invalid
    Followship.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Followship.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  end

  def test_destroy
    followship = Followship.first
    delete :destroy, :id => followship
    assert_redirected_to root_url
    assert !Followship.exists?(followship.id)
  end
end
