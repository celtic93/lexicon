class Word < ApplicationRecord
  validates :rank, :level, presence: true
  validates :en, uniqueness: { scope: %i[ru locale] }, if: -> { ru.present? }

  enum locale: {
    en: 0,
    ru: 1
  }

  default_scope { order(:rank, :ru) }
end
