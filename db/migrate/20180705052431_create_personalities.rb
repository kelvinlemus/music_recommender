class CreatePersonalities < ActiveRecord::Migration[5.2]
  def change
    create_table :personalities do |t|
      t.integer :twitter_profile_id, index: true
      t.string :name
      t.decimal :raw_score
      t.timestamps
    end
  end
end
