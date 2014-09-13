require 'rails_helper'

describe User do
  it {should validate_presence_of (:username)}
  it {should validate_presence_of (:email)}
  it {should validate_presence_of (:personal_rank)}
  it {should validate_presence_of (:mic_style)}
  it {should validate_presence_of (:play_style)}
  it {should validate_presence_of (:desc_words)}
  it {should validate_uniqueness_of (:username)}
  it {should validate_uniqueness_of (:email)}
end
