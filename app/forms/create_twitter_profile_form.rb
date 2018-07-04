class CreateTwitterProfileForm < Reform::Form
  property :username
  validates :username, presence: true
end