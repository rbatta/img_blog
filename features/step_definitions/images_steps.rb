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

Given /^(.*) is signed in$/ do |name|
  @user = User.find_by_name(name)
  visit signin_path
  fill_in "Email", 	with: @user.email
  fill_in "Password", with: @user.password 
  click_button "Sign in"
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
