require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:recipe)).to be_valid
  end

  it 'validates presence of name' do
    expect(FactoryGirl.build(:recipe, name:"", content:"this is content")).to be_invalid
  end

  it 'validates presence of content' do
    expect(FactoryGirl.build(:recipe, name:"recipe", content:"")).to be_invalid
  end

end
