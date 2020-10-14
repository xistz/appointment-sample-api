class ChangeAvailabilityUserId < ActiveRecord::Migration[6.0]
  def change
    rename_column :availabilities, :user_id, :fp_id
  end
end
