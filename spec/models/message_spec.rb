require 'rails_helper'

describe Message do
  it {should validate_presence_of (:subject)}
  it {should validate_presence_of (:body)}
  it {should belong_to(:sender) }
  it {should belong_to(:recipient) }
end
