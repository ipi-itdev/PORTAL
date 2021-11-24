class CreateContactpages < ActiveRecord::Migration[5.1]
  def change
    create_table :contactpages do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.text :message

      t.timestamps
    end
  end
end
