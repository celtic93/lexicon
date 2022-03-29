class Round < ApplicationRecord
  belongs_to :user
  has_many :exercises, dependent: :destroy

  enum status: {
    pending: 0,
    successful: 1,
    failed: 2
  }

  validates :level, presence: true
end
