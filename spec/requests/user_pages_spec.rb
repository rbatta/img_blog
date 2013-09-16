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
        fill_in "Email",            with: "123@test.com"
        fill_in "Password",         with: "password"
        fill_in "Confirm Password", with: "password"
      end
      let(:user) { User.find_by(email: "123@test.com") }

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      it "should redirect to user page with alert" do
        click_button submit
        expect(page).to have_title(user.name)
        expect(page).to have_selector('div.alert.alert-success', text: 'Welcome')
        expect(page).to have_link('Sign out', href: signout_path)
      end
    end
  end

  context "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }
    before { visit edit_user_path(user) }

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
      it { should have_content("Sign out") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    it "should fail with invalid info" do
      click_button "Save changes"
      should have_content('error')
    end

    describe "with valid info" do
      let(:new_name)  { "New person" }
      let(:new_email) { "newb@test.com" }
      before do
        fill_in "Name",     with: new_name
        fill_in "Email",    with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end
