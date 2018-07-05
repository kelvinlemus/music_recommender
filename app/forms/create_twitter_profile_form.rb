class CreateTwitterProfileForm < Reform::Form
  property :username
  property :name
  property :description
  property :user_twitter_id
  property :lang
  property :profile_image_uri
  property :uri

  validates :username, presence: true
  validates_uniqueness_of :username
end
