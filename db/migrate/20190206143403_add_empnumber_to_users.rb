class AddEmpnumberToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :EmployeeNumber, :string
  end
end
