class Search < ActiveRecord::Base
  validates :zip_code, format: {
    with: /\A\d{5}\z/,
    message: "Must only be a 5 digit number." }
end
