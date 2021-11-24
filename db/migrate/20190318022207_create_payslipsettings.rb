class CreatePayslipsettings < ActiveRecord::Migration[5.1]
  def change
    create_table :payslipsettings do |t|
      t.string :description
      t.string :value
      t.string :path
      t.boolean :show
      t.text :note

      t.timestamps
    end
  end
end
