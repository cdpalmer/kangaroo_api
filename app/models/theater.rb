class Theater < ActiveRecord::Base
  has_and_belongs_to_many :searches
  has_many :showtimes
end
