class LanguageUser < ApplicationRecord
  belongs_to :language
  belongs_to :user

  validates :language_id, uniqueness: { scope: :user_id }
end
