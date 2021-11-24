class AddFieldsToKnowledgebase < ActiveRecord::Migration[5.1]
  def change
    add_column :knowledgebases, :title, :string
    add_column :knowledgebases, :article, :text
    add_column :knowledgebases, :author, :string
  end
end
