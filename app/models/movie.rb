class Movie < ApplicationRecord
  has_many :shows, dependent: :destroy

  validates :title, presence: true
  validates :genre, presence: true
  validates :duration, presence: true
  validates :language, presence: true
  validates :rating, presence: true
  validates :release_date, presence: true
end
