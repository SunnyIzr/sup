require 'rails_helper'

describe OutsideActivity do
  it {should have_many(:users)}
  it {should validate_uniqueness_of (:description)}
end
