require 'test_helper'

class UserDetailControllerTest < ActionController::TestCase

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'new should render correct template and layout' do
    get :new
    assert_template :new
    assert_template layout: 'application'
  end

  test 'should get details' do
    get :details, :user_name => 'sferik'
    assert_response :success
    assert_equal 'sferik', assigns('user_name')
  end

  test 'details should render correct template and layout' do
    get :details
    assert_template :details
    assert_template layout: 'application'
  end

  test 'should export details in pdf' do
    get :export, :mime_type => 'pdf', :user_name => 'sferik'
    assert_response :success
    assert_equal 'sferik', assigns('user_name')
  end

  test 'should export details in doc' do
    get :export, :mime_type => 'doc', :user_name => 'sferik'
    assert_response :success
    assert_equal 'sferik', assigns('user_name')
  end

  test 'export should render correct template and layout' do
    get :export, :mime_type => 'pdf'
    assert_template :export
    assert_template layout: 'export'
  end

end
