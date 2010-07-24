require 'test_helper'

class EncountersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:encounters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create encounter" do
    assert_difference('Encounter.count') do
      post :create, :encounter => { }
    end

    assert_redirected_to encounter_path(assigns(:encounter))
  end

  test "should show encounter" do
    get :show, :id => encounters(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => encounters(:one).to_param
    assert_response :success
  end

  test "should update encounter" do
    put :update, :id => encounters(:one).to_param, :encounter => { }
    assert_redirected_to encounter_path(assigns(:encounter))
  end

  test "should destroy encounter" do
    assert_difference('Encounter.count', -1) do
      delete :destroy, :id => encounters(:one).to_param
    end

    assert_redirected_to encounters_path
  end
end
