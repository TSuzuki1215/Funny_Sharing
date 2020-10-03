class RenameUserImg < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :img_url, :user_profile_img_url
  end
end
