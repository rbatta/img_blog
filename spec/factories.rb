FactoryGirl.define do 
	factory :user do
		name			"Risa"
		email			"test@test.com"
		password	"password"
		password_confirmation "password"
	end
end