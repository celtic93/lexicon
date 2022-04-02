class Word < ApplicationRecord
  validates :rank, presence: true
  validates :en, uniqueness: { scope: [:ru, :locale] }, if: -> { ru.present? }

  enum locale: {
    en: 0,
    ru: 1
  }

  default_scope { order(:rank) }
end
