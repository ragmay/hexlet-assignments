require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:bulletin1)
  end

  test 'should get bulletins page' do
    get bulletins_url

    assert_response :success
    assert_select 'h1', 'Bulletins'
  end

  test 'should show bulletin' do
    get bulletin_url @bulletin

    assert_response :success
    assert_select 'p'
  end
end
