class User < ActiveRecord::Base
  serialize :desc_words, Array
end
