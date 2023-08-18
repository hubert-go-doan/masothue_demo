class AddUniqueIndexToPeople < ActiveRecord::Migration[7.0]
  def change
    add_index :people, :cmnd, unique: true
  end
end
