class Word < ApplicationRecord
  validates :rank, presence: true

  enum locale: {
    en: 0,
    ru: 1
  }

  default_scope { order(:rank) }
end
