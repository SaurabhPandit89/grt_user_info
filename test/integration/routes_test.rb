require 'test_helper'

class DefaultRoutingTest < ActionController::TestCase

  test 'should route to root' do
    assert_recognizes({controller: 'user_detail', action: 'new'}, '/')
  end

  test 'should route to new' do
    assert_recognizes({controller: 'user_detail', action: 'new'}, '/user_detail/new')
  end

  test 'should route to details' do
    assert_recognizes({controller: 'user_detail', action: 'details'}, {path: '/user_detail/details', method: :post})
  end

  test 'should route to exports with mime_type pdf' do
    assert_recognizes({controller: 'user_detail', action: 'export', mime_type: 'pdf'}, '/user_detail/export/pdf')
  end

  test 'should route to exports with mime type doc' do
    assert_recognizes({controller: 'user_detail', action: 'export', mime_type: 'doc'}, '/user_detail/export/doc')
  end

end