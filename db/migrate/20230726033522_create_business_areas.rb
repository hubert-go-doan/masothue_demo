class CreateBusinessAreas < ActiveRecord::Migration[7.0]
  def change
    create_table :business_areas do |t|
      t.string :name
      t.string :detail

      t.timestamps
    end
  end
end
