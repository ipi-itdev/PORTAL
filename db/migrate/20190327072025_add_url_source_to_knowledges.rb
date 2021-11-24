class AddUrlSourceToKnowledges < ActiveRecord::Migration[5.1]
  def change
    add_column :knowledges, :source, :string
    add_column :knowledges, :viewpdf, :boolean
  end
end
