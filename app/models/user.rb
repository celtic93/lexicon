class User < ApplicationRecord
  has_many :rounds, dependent: :destroy
  has_many :exercises, dependent: :destroy

  def last_round
    rounds.includes(:exercises).last
  end
end
