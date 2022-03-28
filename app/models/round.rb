class Round < ApplicationRecord
  belongs_to :user
  has_many :exercises

  validates :level, presence: true
end
