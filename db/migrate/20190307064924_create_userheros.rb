class CreateUserheros < ActiveRecord::Migration[5.1]
  def change
    create_table :userheros do |t|
      t.string :name
      t.string :email
      t.string :login

      t.timestamps
    end
  end
end
