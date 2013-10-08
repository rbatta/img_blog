require 'spec_helper'

describe "Image Pages" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "image uploading" do
  	before { visit root_path }

  	context "with invalid information" do
  		it "should not post an image" do
  			pending
  		end

  		describe "error messages" do
  			before { click_button "Upload" }
  			it { should have_content('error') }
  		end
  	end

  end
end
