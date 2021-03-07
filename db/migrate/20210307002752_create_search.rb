class CreateSearch < ActiveRecord::Migration[6.1]
  def change
    create_table :searches do |t|
      t.string :zip_code

      t.timestamps
    end
  end
end
