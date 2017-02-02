require 'rails_helper'

describe "#index" do

  	context "user is not authenticated" do
  		it "must be redirected to the sign_up page" do
  			get root_path
  			response.should redirect_to '/users/sign_up'
  		end
  	end
end