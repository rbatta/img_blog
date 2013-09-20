require 'spec_helper'

describe User do
  before { @user = User.new(name: "Test", email: "test@test.com",
  													password: "password", password_confirmation: "password") }
  subject { @user }

  context "validation for success" do
	  it { should respond_to(:name) }
	  it { should respond_to(:email) }
	  it { should respond_to(:password_digest) }
	  it { should respond_to(:password) }
	  it { should respond_to(:password_confirmation) }
	  it { should respond_to(:authenticate) }
	  it { should respond_to(:remember_token) }
	  it { should respond_to(:admin) }

	  it { should be_valid }
	  it { should_not be_admin }

	  describe "with admin attribute set to TRUE" do
	  	before do
	  		@user.save!
	  		@user.toggle!(:admin)
	  	end

	  	it { should be_admin }
	  end

	  let(:mixed_case_email) { "TesT@TeST.cOM" }
	  it "should have email saved in lowercase" do
	  	@user.email = mixed_case_email
	  	@user.save
	  	expect(@user.reload.email).to eq mixed_case_email.downcase
	  end
	end

	context "validation for failures" do
		it "should fail when name isn't present" do
			@user.name = ""
			should_not be_valid
		end

		it "should fail if name is too long" do
			@user.name = "a" * 51
			should_not be_valid
		end

		it "should fail when email isn't present" do
			@user.email = ""
			should_not be_valid
		end

		it "should fail when email format is invalid" do
			@user.email = "invalidemail@asd."
			should_not be_valid
		end

		it "should fail when email format has 2 dots" do
			@user.email = "invalidemail@asdf..com"
			should be_invalid
		end

		it "should fail when email isn't unique" do
			same_email_user = @user.dup
			same_email_user.email = @user.email.upcase
			same_email_user.save
			should_not be_valid	
		end

		it "should fail if password is not present" do
			@user.password = ""
			@user.password_confirmation = ""
			should be_invalid
		end

		it "should fail if password mismatch" do
			@user.password_confirmation = "mismatch"
			should be_invalid
		end

		it "should fail for short passwords" do
			@user.password = @user.password_confirmation = "a" * 7
			should be_invalid
		end
	end

	context "checking authentication methods" do
		before { @user.save }
		let(:found_user) { User.find_by(email: @user.email) }
		let(:user_with_invalid_pwd) { found_user.authenticate("invalid") }

		it "should return with valid password" do
			should eq found_user.authenticate(@user.password)
		end

		it "should not return with invalid authentication" do
			should_not eq user_with_invalid_pwd
		end

		specify { expect(user_with_invalid_pwd).to be_false }
	end

	context "remember token" do
		before { @user.save }
		its(:remember_token) { should_not be_blank }
		# equivalent to it { expect(@user.remember_token).not_to be_blank }
	end
end
