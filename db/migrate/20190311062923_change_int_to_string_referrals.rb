class ChangeIntToStringReferrals < ActiveRecord::Migration[5.1]
  def change


  	change_column :referrals, :phone, :string

  end
end
