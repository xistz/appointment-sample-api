class RemoveToFromAvailabilities < ActiveRecord::Migration[6.0]
  def change
    remove_column :availabilities, :to, :datetime, null: false
  end
end
