class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :mentor_name
      t.string :account
      t.string :discroption
      t.string :password_digest
      t.string :user_plofile_img_url
      t.timestamps null: false
      t.index [:mentor_name, :account], unique: true
    end

    create_table :comedy_stories do |t|
      t.integer :user_id
      t.integer :camp_id
      t.string :funny_comment_body
      t.string :video_url
      t.integer :good_count
      t.integer :funny_count
      t.integer :total_point
      t.timestamps null: false
    end

    create_table :relationships do |t|
      t.integer :user_id
      t.integer :follow_user_id
      t.timestamps null: false
      t.index [:user_id, :follow_user_id], unique: true

    end

    create_table :likes do |t|
      t.integer :user_id
      t.integer :comedy_story_id
      t.timestamps null: false
      t.index [:user_id, :comedy_story_id], unique: true
    end

    create_table :funnys do |t|
      t.integer :user_id
      t.integer :comedy_story_id
      t.timestamps null: false
      t.index [:user_id, :comedy_story_id], unique: true

    end

    create_table :camps do |t|
      t.string :camp_period
      t.string :camp_name
    end


  end
end
