class RemoveRepresentReferenceFromPeople < ActiveRecord::Migration[7.0]
  def change
    remove_reference :people, :represent, foreign_key: true
  end
end
