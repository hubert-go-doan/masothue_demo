class CreateCompanyTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :company_types do |t|
      t.string :type_name

      t.timestamps
    end
  end
end
