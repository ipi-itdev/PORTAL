class CreateReferrals < ActiveRecord::Migration[5.1]
  def change
    create_table :referrals do |t|
      t.string :name
      t.string :address
      t.string :email
      t.integer :phone
      t.string :position
      t.text :note
      t.integer :employeerefno

      t.timestamps
    end
  end
end
