Given /^a user visits the signin page$/ do
  visit signin_path
end

Given(/^a user has an account$/) do
  @user = User.create(name: "Test", email: "test@test.com",
  										password: "password", password_confirmation: "password")
end


When(/^she submits invalid signin info$/) do
  click_button "Sign in"
end

Then /^she should see an error message$/ do
  expect(page).to have_selector('div.alert.alert-error')
end

When(/^she submits valid signin info$/) do
  fill_in "Email", 				with: @user.email
  fill_in "Password", 		with: @user.password
  click_button "Sign in"
end

Then(/^she should see her profile page$/) do
  expect(page).to have_title(@user.name)
end

Then(/^she should see a signout link$/) do
  expect(page).to have_link('Sign out', href: signout_path)
end