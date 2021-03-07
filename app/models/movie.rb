class Movie < ActiveRecord::Base
  has_many :theaters, through: :showtimes
  has_many :showtimes
end
