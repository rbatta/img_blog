require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "signin page" do
  	before { visit signin_path }

  	it { should have_content('Sign in') }
  	it { should have_title('Sign in') }

  	context "logging in with invalid info" do
  		it "should display error" do
	  		click_button "Sign in"
	  		should have_title('Sign in')
	  		should have_selector('div.alert.alert-error', text: 'Invalid')
	  	end

	  	it "should not have alert persist on other pages" do
	  		click_link "Home"
	  		should_not have_selector('div.alert.alert-error')
	  	end
  	end

  	context "logging in with valid info" do
  		let(:user) { FactoryGirl.create(:user) }
  		before { valid_signin(user) }

  		it { should have_title(user.name) }
  		it { should have_link('Profile', 			href: user_path(user)) }
  		it { should have_link('Sign out', 		href: signout_path) }
  		it { should_not have_link('Sign in',	href: signin_path) }

  		describe "followed by signout" do
  			before { click_link "Sign out" }
  			it { should have_link('Sign in') }
  		end
  	end
  end
end
