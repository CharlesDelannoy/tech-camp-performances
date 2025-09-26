class AddIndexToAppointmentsOnAgendaIdAndStartDate < ActiveRecord::Migration[8.0]
  def change
    add_index :appointments, [:agenda_id, :start_date], name: 'index_appointments_on_agenda_id_and_start_date'
  end
end
