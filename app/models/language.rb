class Language < ApplicationRecord
  has_many :words

  validates :name, presence: true
end
