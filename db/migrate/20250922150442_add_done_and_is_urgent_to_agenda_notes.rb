class AddDoneAndIsUrgentToAgendaNotes < ActiveRecord::Migration[8.0]
  def change
    add_column :agenda_notes, :done, :boolean, default: false
    add_column :agenda_notes, :is_urgent, :boolean, default: false
  end
end
