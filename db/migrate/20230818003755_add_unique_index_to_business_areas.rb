class AddUniqueIndexToBusinessAreas < ActiveRecord::Migration[7.0]
  def change
    add_index :business_areas, :name, unique: true
  end
end
