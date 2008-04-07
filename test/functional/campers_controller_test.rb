require File.dirname(__FILE__) + '/../test_helper'

class CampersControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:campers)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_camper
    assert_difference('Camper.count') do
      post :create, :camper => { }
    end

    assert_redirected_to camper_path(assigns(:camper))
  end

  def test_should_show_camper
    get :show, :id => campers(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => campers(:one).id
    assert_response :success
  end

  def test_should_update_camper
    put :update, :id => campers(:one).id, :camper => { }
    assert_redirected_to camper_path(assigns(:camper))
  end

  def test_should_destroy_camper
    assert_difference('Camper.count', -1) do
      delete :destroy, :id => campers(:one).id
    end

    assert_redirected_to campers_path
  end
end
