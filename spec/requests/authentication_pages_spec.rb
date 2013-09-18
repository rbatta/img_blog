require 'spec_helper'

describe "Authentication" do
  subject { page }

  context "signin page" do
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
      it { should have_link('Settings',     href: edit_user_path(user)) }
  		it { should have_link('Sign out', 		href: signout_path) }
  		it { should_not have_link('Sign in',	href: signin_path) }

  		describe "followed by signout" do
  			before { click_link "Sign out" }
  			it { should have_link('Sign in') }
  		end
  	end
  end

  context "authorization" do
    context "for non-signed in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the User Controller" do
        context "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end

        context "submitting to update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to signin_path }
        end
      end
    end

    context "for the wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@test.com") }
      before { sign_in user, no_capybara: true }

      context "submitting a GET request to Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to root_url }
      end

      context "submitting a PATCH to Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to root_url }
      end

    end
  end

end
