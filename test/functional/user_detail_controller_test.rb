require 'test_helper'

class UserDetailControllerTest < ActionController::TestCase

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should get details' do
    get :details
    assert_response :success
  end

  test 'should export details in pdf' do
    get :export, :mime_type => 'pdf'
    assert_response :success
  end

  test 'should export details in doc' do
    get :export, :mime_type => 'doc'
    assert_response :success
  end

end
