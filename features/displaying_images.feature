Feature: Displaying images

  As a signed in user
  So that I can quickly see my images
  I want to see the image title and description

Background: images have been added to database

	Given the following users exist:
	| name 			 | email 						| admin   | password | password_confirmation |
	| Admin		   | admin@test.com		| true    | password | password 						 |
	| Test   		 | test@test.com		| false		| password | password 						 |

  And the following images exist for Test:
  | img_name   | description 									| tags              |
  | Dog        | Cute dog rolling around      | cute, gif         |
  | Kitty      | Cute kitty playing 		      | funny, cute, gif  |

Scenario: Displaying descriptions of images on user page
  Given Test is signed in
  When Test visits her profile
  Then she should see the title 'Images'
  And she should see an image
  And she should see the description: "Cute kitty playing"
  And she should see the tags: "funny, cute, gif"
  And she should see a link to view the image

Scenario: Follow an image to its own page
#TODO: set this up