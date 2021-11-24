class AddAttachmentToKnowledges < ActiveRecord::Migration[5.1]
  def change
    add_column :knowledges, :attachment, :string
  end
end
