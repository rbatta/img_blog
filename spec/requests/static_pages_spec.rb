require 'spec_helper'

describe "StaticPages" do

  subject { page }

  # this code eliminates redundant tests with it_should_behave_like
  # referencing shared_examples_for
  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading) { 'Image Blog' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_title('| Home') }
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading) { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About me" do
  	before { visit about_path }
    let(:heading) { 'About me' }
    let(:page_title) { 'About me' }

    it_should_behave_like "all static pages"
  end

  describe "Contact me" do
  	before { visit contact_path }
    let(:heading) { 'Contact' }
    let(:page_title) { 'Contact' }

    it_should_behave_like "all static pages"
  end

  # check if links all work properly
  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About me'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Home"
    click_link "Sign up"
    expect(page).to have_title(full_title('Sign up'))
    click_link "image blog"
    expect(page).to have_title(full_title(''))
  end
end
