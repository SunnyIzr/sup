require 'rails_helper'

describe Game do
  it {should belong_to (:platform)}
  it {should validate_presence_of (:title)}
  it {should have_many (:users)}
end