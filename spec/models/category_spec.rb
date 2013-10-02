require 'spec_helper'

describe Category do
  let(:img) { FactoryGirl.create(:image) }

  #before { @category = Category.new(category: "funny", image_id: img.id) }
  before { @category = img.categories.build(category: "funny", image_id: img.id) }
  
  subject { @category }

  it { should respond_to(:category) }
  it { should respond_to(:image_id) }
  it { should be_valid }

  describe "when image id is nil" do
  	before { @category.image_id = nil }
  	it { should_not be_valid }
  end

  describe "when category is nil" do
    before { @category.category = "" }
    it { should_not be_valid }
  end

  describe "when category is too long" do
    before { @category.category = "a" * 51 }
    it { should_not be_valid }
  end
end
