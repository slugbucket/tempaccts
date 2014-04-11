require 'test_helper'

class AccountGroupTempacctsControllerTest < ActionController::TestCase
  setup do
    @account_group_tempacct = account_group_tempaccts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:account_group_tempaccts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account_group_tempacct" do
    assert_difference('AccountGroupTempacct.count') do
      post :create, account_group_tempacct: { acct_group_id: @account_group_tempacct.acct_group_id, tempacct_id: @account_group_tempacct.tempacct_id }
    end

    assert_redirected_to account_group_tempacct_path(assigns(:account_group_tempacct))
  end

  test "should show account_group_tempacct" do
    get :show, id: @account_group_tempacct
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @account_group_tempacct
    assert_response :success
  end

  test "should update account_group_tempacct" do
    patch :update, id: @account_group_tempacct, account_group_tempacct: { acct_group_id: @account_group_tempacct.acct_group_id, tempacct_id: @account_group_tempacct.tempacct_id }
    assert_redirected_to account_group_tempacct_path(assigns(:account_group_tempacct))
  end

  test "should destroy account_group_tempacct" do
    assert_difference('AccountGroupTempacct.count', -1) do
      delete :destroy, id: @account_group_tempacct
    end

    assert_redirected_to account_group_tempaccts_path
  end
end
