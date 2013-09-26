require 'spec_helper'

describe Image do
  let(:user) { FactoryGirl.create(:user) }
  before { @img = user.images.build(img_name: "picture", description: "pic desc") }

  subject { @img }

  it { should respond_to(:img_name) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  context "when user id is not present" do
  	before { @img.user_id = nil }
  	it { should_not be_valid }
  end
end
