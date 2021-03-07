class CreateMovieAndShowtimes < ActiveRecord::Migration[6.1]
  def change
    create_table :showtimes do |t|
      t.belongs_to    :movie
      t.belongs_to    :theater
      t.integer       :start_time

      t.timestamps
    end

    create_table :movies do |t|
      t.string  :description
      t.string  :title
      t.integer :duration

      t.timestamps
    end
  end
end
