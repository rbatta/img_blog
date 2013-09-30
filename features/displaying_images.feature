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
  | img_name   | description 									| 
  | Dog        | Cute dog rolling around      |
  | Kitty      | Cute kitty playing 		      |

Scenario: Displaying descriptions of images on user page
  Given Test is signed in
  When Test visits her profile
  And show me the page
  Then she should see the title 'Images'
  And she should see descriptions of her images
  And she can click to view the image
#TODO: set this up