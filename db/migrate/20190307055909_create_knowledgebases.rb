class CreateKnowledgebases < ActiveRecord::Migration[5.1]
  def change
    create_table :knowledgebases do |t|

      t.timestamps
    end
  end
end
