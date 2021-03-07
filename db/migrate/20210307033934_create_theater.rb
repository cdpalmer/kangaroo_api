class CreateTheater < ActiveRecord::Migration[6.1]
  def change
    create_table :theaters do |t|
      t.string    :zip_code
      t.string    :title
      t.string    :address

      t.timestamps
    end

    create_table :searches_theaters do |t|
      t.belongs_to :search, index: :true
      t.belongs_to :theater, index: :true
    end
  end
end
