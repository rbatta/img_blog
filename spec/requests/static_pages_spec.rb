require 'spec_helper'

describe "StaticPages" do

  describe "Home page" do
    it "should have content 'Image Blog'" do
    	visit '/static_pages/home'
    	expect(page).to have_content('Image Blog')
    end
  end
end
