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
      let!(:img1) { FactoryGirl.create(:image, user: user, img_name: "Dog", description: "Dog description.") }
      let!(:img2) { FactoryGirl.create(:image, user: user, img_name: "Cat", description: "Cat description!!") }
    	
      before { visit user_path(user) }

    	it { should have_content(user.name) }
    	it { should have_title(user.name) }

      describe "image listings" do
        it { should have_content(img1.img_name) }
        it { should have_content(img1.description) }
        it { should have_content(img1.tags) }
        it { should have_css('.images img') }
      end
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
    before do 
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
      it { should have_content("Sign out") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }

      describe "when changing gravatar" do
        it "should open a new page" do
          expect(page).to have_selector("a[href='http://gravatar.com/emails'][target='_blank']")
        end
      end
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

    describe "forbidden access" do
      let(:params) do
        { user: { admin: true, password: user.password,
                  password_confirmation: user.password } }
      end
      before do
        sign_in user, no_capybara: true
        patch user_path(user), params
      end
      specify { expect(user.reload).not_to be_admin }
    end
  end

  context "index" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title('All Users') }
    it { should have_content('All Users') }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do
      it { should_not have_link('Delete') }

      describe "as an admin" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('Delete', href: user_path(User.first)) }
        it "should be able to del another user" do
          expect do
            click_link('Delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('Delete', href: user_path(admin)) }
      end
    end
  end
end
