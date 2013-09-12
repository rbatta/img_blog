Feature: Signing in

Scenario: Unsuccessful signin
	Given a user visits the signin page
	When she submits invalid signin info
	Then she should see an error message

Scenario: Successful signin
	Given a user has an account
	And a user visits the signin page
	When she submits valid signin info
	Then she should see her profile page
	And she should see a signout link
