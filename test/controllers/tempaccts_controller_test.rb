require 'test_helper'

class TempacctsControllerTest < ActionController::TestCase
  setup do
    @tempacct = tempaccts(:three)
    @newacct = {
        :firstname         => 'Sydney',
        :surname           => 'Solipsism',
        :uid               => 'solsy01',
        :password          => 'Solsy-01',
        :owner             => 'Research and Development',
        :expiry_date       => '2014-03-29',
        :account_type_id   => '1',
        :ftp_login         => '1',
        :in_ldap           => '0',
        :printing          => '0',
        :description       => 'Temporary contractor.'
    }
    @update = {
      expiry_date:    '2014-16-16 20:38:19',
      resource_acct:   '1',
      ftp_login:       '1',
      wireless_guest:  '0'
    }
    @six_mnth_exp = {
      expiry_date:    '2014-12-16 20:38:19',
    }
    request.host = 'tempaccts'
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tempaccts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tempacct" do
    assert_difference('Tempacct.count', 1, "Temporary account does not appear to have been created") do
      post :create, tempacct:  @newacct 
    end

    assert_redirected_to tempacct_path(assigns(:tempacct))
  end

  test "should show tempacct" do
    get :show, id: @tempacct
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tempacct
    assert_response :success
  end

  test "should update tempacct" do
    patch :update, id: @tempacct, tempacct: @update
    assert_redirected_to tempacct_path #(assigns(:tempacct))
  end

  test "should destroy tempacct" do
    assert_difference('Tempacct.count', -1) do
      delete :destroy, id: @tempacct
    end

    assert_redirected_to tempaccts_url
  end

  test "should fail if expiry too long"
  end
end
