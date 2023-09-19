class ChangeRepresentIdToNullableInCompanies < ActiveRecord::Migration[7.0]
  def change
    change_column :companies, :represent_id, :bigint, null: true
  end
end
