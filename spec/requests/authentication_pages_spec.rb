require 'spec_helper'

describe "Authentication" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }

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
  		before { valid_signin(user) }

  		it { should have_title(user.name) }
      it { should have_link('Users',        href: users_path) }
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

      context "in the User Controller" do
        context "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
          it { should_not have_link('Profile', href: user_path(user)) }
          it { should_not have_link('Settings', href: edit_user_path(user)) }
        end

        context "submitting to update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to signin_path }
        end

        context "visiting the users index" do
          before { visit users_path }
          it { should have_title('Sign in') }
        end
      end

      context "when trying to get to a protected area" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password 
          click_button "Sign in"
        end

        describe "after signing in" do
          it "should redirect to page they wanted" do 
            expect(page).to have_title("Edit user")
          end
        end
      end
    end

    context "for the wrong user" do
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

    context "as non-admin users" do
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitted DELETE request to Users#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to root_url }
      end
    end

    context "for signed in users" do
      before { sign_in user, no_capybara: true }

      describe "attempting GET request to Users#new action" do
        before { get new_user_path }
        specify { expect(response).to redirect_to root_url }
      end

      describe "attempting POST request to Users#create" do
        let(:params) do
        { user: { admin: true, password: user.password,
                  password_confirmation: user.password } }
        end
        before do
          sign_in user, no_capybara: true
          post users_path, params
        end
        specify { expect(response).to redirect_to root_url }
      end
    end
  end
end
