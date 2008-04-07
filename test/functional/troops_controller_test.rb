require File.dirname(__FILE__) + '/../test_helper'

class TroopsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:troops)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_troop
    assert_difference('Troop.count') do
      post :create, :troop => { }
    end

    assert_redirected_to troop_path(assigns(:troop))
  end

  def test_should_show_troop
    get :show, :id => troops(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => troops(:one).id
    assert_response :success
  end

  def test_should_update_troop
    put :update, :id => troops(:one).id, :troop => { }
    assert_redirected_to troop_path(assigns(:troop))
  end

  def test_should_destroy_troop
    assert_difference('Troop.count', -1) do
      delete :destroy, :id => troops(:one).id
    end

    assert_redirected_to troops_path
  end
end
