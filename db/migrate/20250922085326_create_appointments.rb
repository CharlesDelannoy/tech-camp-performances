class CreateAppointments < ActiveRecord::Migration[8.0]
  def change
    create_table :appointments do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.references :agenda, null: false, foreign_key: true

      t.timestamps
    end
  end
end
