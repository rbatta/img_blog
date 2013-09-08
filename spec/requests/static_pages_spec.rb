require 'spec_helper'

describe "StaticPages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }
    it { should have_content('Image Blog') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }
  end

  describe "Help page" do
    before { visit help_path }
  	it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
  end

  describe "About me" do
  	before { visit about_path }
    it { should have_title('About me') }
    it { should have_content('About me') }
  end

  describe "Contact me" do
  	before { visit contact_path }
    it { should have_content('Contact') }
    it { should have_title('Contact') }
  end
end
