require 'rails_helper'

RSpec.describe User, type: :model do
  Factory.create(:user).should be_valid
end
