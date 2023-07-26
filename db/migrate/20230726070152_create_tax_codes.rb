class CreateTaxCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :tax_codes do |t|
      t.string :code
      t.references :taxable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
