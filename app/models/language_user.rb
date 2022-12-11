class LanguageUser < ApplicationRecord
  belongs_to :language
  belongs_to :user
  has_many :rounds, dependent: :destroy

  validates :language_id, uniqueness: { scope: :user_id }
end
