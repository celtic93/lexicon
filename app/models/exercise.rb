class Exercise < ApplicationRecord
  belongs_to :user
  belongs_to :word
  belongs_to :rounds
end
