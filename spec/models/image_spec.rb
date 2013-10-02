require 'spec_helper'

describe Image do
  let(:user) { FactoryGirl.create(:user) }
  before { @img = user.images.build(img_name: "picture", description: "pic desc", tags: "funny, cute, gif") } 

  subject { @img }

  it { should respond_to(:img_name) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:tags) }
  its(:user) { should eq user }

  it { should be_valid }

  context "when user id is not present" do
  	before { @img.user_id = nil }
  	it { should_not be_valid }
  end

  context "with blank description" do
    before { @img.description = "" }
    it { should_not be_valid }
  end

  context "with description that is too long" do
    before { @img.description = "a" * 251 }
    it { should_not be_valid }
  end

  context "with blank image name" do
    before { @img.img_name = "" }
    it { should_not be_valid }
  end

  context "with image name that is too long" do
    before { @img.img_name = "a" * 81 }
    it { should_not be_valid }
  end

  context "with blank tags" do
    before { @img.tags = "" }
    it { should_not be_valid }
  end
end
