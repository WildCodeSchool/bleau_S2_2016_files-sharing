require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest

  test "should redirect on login page if user is not authentified" do
    get '/'
    assert_redirected_to '/users/sign_up'
  end

  test "should get index" do
    get '/'
    assert_redirected_to '/users/sign_up'
  end

end
