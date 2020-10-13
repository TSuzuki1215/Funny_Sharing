class RenameFunnysToFunnies < ActiveRecord::Migration[5.2]
  def change
    rename_table :funnys, :funnies
  end
end
