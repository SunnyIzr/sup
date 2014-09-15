require 'rails_helper'

describe Platform do
  it {should have_many(:games)}
  it {should validate_uniqueness_of (:name)}
  it {should validate_presence_of (:name)}
end