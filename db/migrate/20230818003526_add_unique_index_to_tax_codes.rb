class AddUniqueIndexToTaxCodes < ActiveRecord::Migration[7.0]
  def change
    add_index :tax_codes, :code, unique: true
  end
end
