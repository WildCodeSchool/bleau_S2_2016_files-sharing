describe "#index" do

  	context "user is not authenticated" do
  		it { is_expected.to respond_with 200 }
  	end
end