class ChangeColumnnamePositionToSkills < ActiveRecord::Migration[5.1]
  def change
  	rename_column :referrals, :position, :skills
  	rename_column :referrals, :note, :remarks
  end
end
