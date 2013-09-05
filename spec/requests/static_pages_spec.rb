require 'spec_helper'

describe "StaticPages" do

  describe "Home page" do
    it "should have references to correct location" do
    	visit '/static_pages/home'
    	expect(page).to have_content('Image Blog')
    end

    it "should have a base title per ModuleHelper" do
    	visit '/static_pages/home'
    	expect(page).to have_title("Image Blog")
    end

    it "should not have a custom page title" do
    	visit '/static_pages/home'
    	expect(page).not_to have_title(' | Home')
    end
  end

  describe "Help page" do
  	it "should have references to correct location" do
  		visit '/static_pages/help'
  		expect(page).to have_content('Help')
  		expect(page).to have_title("Help")
  	end
  end

  describe "About me" do
  	it "should have references to correct location" do
  		visit '/static_pages/about'
  		expect(page).to have_content('About me')
  		expect(page).to have_title("About me")
  	end
  end

  describe "Contact me" do
  	it "should have references to correct location" do
  		visit '/static_pages/contact'
  		expect(page).to have_content('Contact me')
  		expect(page).to have_title('Contact me')
  	end
  end
end
