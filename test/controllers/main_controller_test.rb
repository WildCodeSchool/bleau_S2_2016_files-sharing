require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest

	setup do
		@current_user = users(:one)
	end

	test "should redirect on login page if user is not authentified" do
		get '/'
		assert_redirected_to '/users/sign_up'
	end

	# test "should get index if user is sign in" do
	# 	session[:user_id] = @current_user.id
	# 	get :index
	# 	assert_response :success
	# end

end
