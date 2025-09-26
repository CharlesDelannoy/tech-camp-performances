class CreateImportFiles < ActiveRecord::Migration[8.0]
  def change
    create_table :import_files do |t|
      t.string :filename
      t.text :normalized_content

      t.timestamps
    end
  end
end
