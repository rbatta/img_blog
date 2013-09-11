require 'spec_helper'

describe "UserPages" do
	subject { page }

  context "viewing individual page" do
    describe "for signup page" do
      before { visit signup_path }

      it { should have_content('Sign up') }
      it { should have_title(full_title('Sign up')) }
    end

    describe "profile page" do
    	let(:user) { FactoryGirl.create(:user) }
    	before { visit user_path(user) }

    	it { should have_content(user.name) }
    	it { should have_title(user.name) }
    end
  end

  context "signup process" do
    before { visit signup_path }
    let(:submit) { "Create an account" }

    context "with invalid info" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('error') }
        it { should have_content('Email is invalid') }
      end
    end

    context "with valid info" do
      before do
        fill_in "Name",             with: "example"
        fill_in "Email",            with: "test@test.com"
        fill_in "Password",         with: "password"
        fill_in "Confirm Password", with: "password"
      end
      let(:user) { User.find_by(email: "test@test.com") }

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      it "should redirect to user page with alert" do
        click_button submit
        expect(page).to have_title(user.name)
        expect(page).to have_selector('div.alert.alert-success', text: 'Welcome')
      end
    end
  end
  
end
