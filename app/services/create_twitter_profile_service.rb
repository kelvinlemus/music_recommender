class CreateTwitterProfileService < BaseService
  def process
    begin
      user = twitter_client.user(self.options[:form].username)
      assign_attributes_to_form(user)
      self.options[:form].save

      watson_params = get_watson_params_for(user)
      watson_result = FetchWatsonPersonality.(
        twitter_profile: self.options[:form].model,
        params: watson_params
      )

      self.result.success!
    rescue Twitter::Error::NotFound
      self.result.failure!
      self.result["message"] = "User not found"
    rescue Exception => e
      self.result.failure!
      self.result["message"] = "Error: #{e.message}"
    end
  end

private
  def assign_attributes_to_form(user)
    self.options[:form].tap do |f|
      f.name = user.name
      f.description = user.description
      f.user_twitter_id = user.id
      f.lang = user.lang
      f.profile_image_uri = user.profile_image_uri
      f.uri = user.uri
    end
  end

  def get_watson_params_for(user)
    _params = { contentItems: [] }
    tweets = twitter_client.user_timeline(user.id, count: 100)
    tweets.each do |tweet|
      _params[:contentItems] << {
        content: tweet.text,
        contenttype: "text/plain",
        created: tweet.created_at.to_i,
        id: tweet.id,
        language: tweet.lang
      }
    end
    _params
  end
end
