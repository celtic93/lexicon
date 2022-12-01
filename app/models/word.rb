class Word < ApplicationRecord
  belongs_to :language

  validates :rank, :level, presence: true
  validates :native, uniqueness: { scope: %i[ru locale] }, if: -> { ru.present? }

  enum locale: {
    native: 0,
    ru: 1
  }

  default_scope { order(:rank, :ru) }
end
