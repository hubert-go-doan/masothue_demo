class CreateRepresents < ActiveRecord::Migration[7.0]
  def change
    create_table :represents do |t|
      t.string :name
      t.date :day_of_birth

      t.timestamps
    end
  end
end
