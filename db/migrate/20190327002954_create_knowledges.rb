class CreateKnowledges < ActiveRecord::Migration[5.1]
  def change
    create_table :knowledges do |t|
      t.string :title
      t.text :content
      t.string :createdby
      t.integer :category
      t.string :summary

      t.timestamps
    end
  end
end
