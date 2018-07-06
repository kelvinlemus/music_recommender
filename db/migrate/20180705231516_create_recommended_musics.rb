class CreateRecommendedMusics < ActiveRecord::Migration[5.2]
  def change
    create_table :recommended_musics do |t|
      t.integer :twitter_profile_id, index: true
      t.integer :personality_id
      t.string :tag
      t.string :album_name
      t.string :album_url
      t.string :album_artist_name
      t.timestamps
    end
  end
end
