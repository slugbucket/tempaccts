require 'test_helper'

class AccountGroupsControllerTest < ActionController::TestCase
  setup do
    @account_group = account_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:account_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account_group" do
    assert_difference('AccountGroup.count') do
      post :create, account_group: { default_expiry: @account_group.default_expiry, description: @account_group.description, name: @account_group.name }
    end

    assert_redirected_to account_group_path(assigns(:account_group))
  end

  test "should show account_group" do
    get :show, id: @account_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @account_group
    assert_response :success
  end

  test "should update account_group" do
    patch :update, id: @account_group, account_group: { default_expiry: @account_group.default_expiry, description: @account_group.description, name: @account_group.name }
    assert_redirected_to account_group_path(assigns(:account_group))
  end

  test "should destroy account_group" do
    assert_difference('AccountGroup.count', -1) do
      delete :destroy, id: @account_group
    end

    assert_redirected_to account_groups_path
  end
end
