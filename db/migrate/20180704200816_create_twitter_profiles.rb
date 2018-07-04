class CreateTwitterProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :twitter_profiles do |t|
      t.string :username, index: true
      t.timestamps
    end
  end
end
