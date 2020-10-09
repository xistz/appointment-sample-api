class CombineDateAndTimeToDateTime < ActiveRecord::Migration[6.0]
  def change
    remove_column :availabilities, :date, :date, null: false

    change_column :availabilities, :from, :datetime, null: false
    change_column :availabilities, :to, :datetime, null: false
  end
end
