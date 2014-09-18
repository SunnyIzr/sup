require 'rails_helper'

describe Match do
  it {should belong_to (:user)}
  it {should belong_to (:matched_user)}
end