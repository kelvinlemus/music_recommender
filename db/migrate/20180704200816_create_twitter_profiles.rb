class CreateTwitterProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :twitter_profiles do |t|
      t.string :username, index: true
      t.string :name
      t.string :user_twitter_id
      t.string :description
      t.string :lang
      t.string :uri
      t.string :profile_image_uri
      t.timestamps
    end
  end
end
