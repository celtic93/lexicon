class User < ApplicationRecord
  has_many :rounds
  has_many :exercises

  def last_round
    rounds.includes(:exercises).last
  end
end
