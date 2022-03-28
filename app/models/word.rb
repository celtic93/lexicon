class Word < ApplicationRecord
  validates :en, uniqueness: { scope: :ru }
  validates :rank, presence: true

  default_scope { order(:rank) }
end
