require 'rails_helper'

describe Match do
  it {should have_many (:users)}
end