class User < ApplicationRecord
  belongs_to :current_language_user, class_name: 'LanguageUser'
  has_one :language, through: :current_language_user
  has_many :rounds, through: :current_language_user
  has_many :exercises, dependent: :destroy

  delegate :level, to: :current_language_user

  def last_round
    rounds.includes(:exercises).last
  end
end
