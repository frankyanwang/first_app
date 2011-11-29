require 'test_helper'

class AuthenticationsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Authentication.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Authentication.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Authentication.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to authentication_url(assigns(:authentication))
  end

  def test_edit
    get :edit, :id => Authentication.first
    assert_template 'edit'
  end

  def test_update_invalid
    Authentication.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Authentication.first
    assert_template 'edit'
  end

  def test_update_valid
    Authentication.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Authentication.first
    assert_redirected_to authentication_url(assigns(:authentication))
  end

  def test_destroy
    authentication = Authentication.first
    delete :destroy, :id => authentication
    assert_redirected_to authentications_url
    assert !Authentication.exists?(authentication.id)
  end
end
