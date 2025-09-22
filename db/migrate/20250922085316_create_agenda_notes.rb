class CreateAgendaNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :agenda_notes do |t|
      t.text :note
      t.references :agenda, null: false, foreign_key: true

      t.timestamps
    end
  end
end
