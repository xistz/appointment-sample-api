class CreateAvailabilities < ActiveRecord::Migration[6.0]
  def change
    create_table :availabilities do |t|
      t.string :user_id, null: false
      t.date :date, null: false
      t.time :from, null: false
      t.time :to, null: false

      t.timestamps
    end
  end
end
