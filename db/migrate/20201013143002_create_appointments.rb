class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.references :availability, foreign_key: true, index: { unique: true }
      t.string :client_id, null: false

      t.timestamps
    end
  end
end
