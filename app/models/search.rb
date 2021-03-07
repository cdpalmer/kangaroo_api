class Search < ActiveRecord::Base
  has_and_belongs_to_many :theaters
  validates :zip_code, format: {
    with: /\A\d{5}\z/,
    message: "Must only be a 5 digit number." }
end
