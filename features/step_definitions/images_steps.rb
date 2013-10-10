Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create!(user) 
  end
end

Given /the following images exist for Test/ do |images_table|
  @user = User.find_by_name('Test')
  images_table.hashes.each do |image|
    @user.images.create!(image) 
  end
end

Given /^Test is( not)? signed in$/ do |negate|
  unless negate
    user = User.find_by_name('Test')
    logon_for_user user
  end  
end

When /^(.*) visits her profile$/ do |name|
	@user = User.find_by_name(name)
  visit user_path(@user)
end

Then /^she should see the title '(.*)'$/ do |word|
  expect(page).to have_content(word)
end

Then /^she should see an image$/ do 
  expect(page).to have_css('.images img')
end

Then(/^she should see the (.*): "(.*)"$/) do |type, phrase|
  case type
  when "description" 
    expect(page).to have_content(phrase)
  when "tags"
    expect(page).to have_content(phrase)
  end
end

Then(/^she should see a link to view the image$/) do
  expect(page).to have_link('Kitty')
end

When(/^show me the page$/) do
  save_and_open_page
end

Given /^(.*) goes to her profile page$/ do |name|
  @user = User.find_by_name(name)
  logon_for_user(@user)
  steps %Q{
    When #{name} visits her profile
  }
end

When /^she clicks on the name "(.*?)"$/ do |title|
  click_link(title)
end

Then /^she should be on the image page for "(.*?)"$/ do |title|
  @img = Image.find_by_img_name(title)
  current_path.should == image_path(@img)
end

Then(/^she should see the image for "(.*?)"$/) do |title|
  @img = Image.find_by_img_name(title)
  expect(page).to have_css('img')
end

Given /^a (non-)user visits (.*)'s profile page$/ do |negate, name|
  @user = User.find_by_name(name)
  visit user_path(@user)
end

Then /^she should be redirected to the sign in page$/ do
  current_path.should == signin_path
end


def logon_for_user(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end