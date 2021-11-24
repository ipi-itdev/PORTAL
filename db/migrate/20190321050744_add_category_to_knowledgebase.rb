class AddCategoryToKnowledgebase < ActiveRecord::Migration[5.1]
  def change
    add_column :knowledgebases, :category, :string
  end
end
