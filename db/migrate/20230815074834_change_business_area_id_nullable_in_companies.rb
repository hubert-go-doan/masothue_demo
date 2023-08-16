class ChangeBusinessAreaIdNullableInCompanies < ActiveRecord::Migration[7.0]
  def change
    change_column :companies, :business_area_id, :bigint, null: true
  end
end
