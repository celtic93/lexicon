class Exercise < ApplicationRecord
  belongs_to :user
  belongs_to :word
  belongs_to :round

  validates :locale, presence: true

  enum status: {
    pending: 0,
    hinted: 1,
    incorrect: 2,
    correct: 3
  }

  enum locale: {
    en: 0,
    ru: 1
  }
end
