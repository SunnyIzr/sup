require 'rails_helper'

describe Trait do
  it {should have_many(:users)}
end
