class AddOwnerToPeople < ActiveRecord::Migration
  def change
    add_reference :people, :owner, index: true, foreign_key: true
    add_foreign_key :people, :users, column: :owner_id
  end
end
