require 'spec_helper'

describe ImagesController do
	before do 
		@user = FactoryGirl.create(:user)
		@img = FactoryGirl.create(:image) 
	end

	context "images#show" do
		it "should show images" do
			get :show, {id: 1}
		end
	end
end