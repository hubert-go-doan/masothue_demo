class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :cmnd
      t.string :address
      t.date :date_start
      t.string :phone_number
      t.string :managed_by
      t.references :represent, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true
      t.references :district, null: false, foreign_key: true
      t.references :ward, null: false, foreign_key: true
      t.references :company_type, null: false, foreign_key: true
      t.references :status, null: false, foreign_key: true

      t.timestamps
    end
  end
end
