class FetchRecommendedMusic < BaseService
  PERSONALITY_TO_MUSIC_TAG = {
    "Openness" => ["Classical", "blues", "jazz", "folk"],
    "Extraversion" => ["rap", "hip hop", "soul", "electronic", "dance"],
    "Agreeableness" => ["upbeat"], #  3 top from upbeat, 3 random from genres on this list.
    "Neuroticism" => ["Country", "pop"],
    "Conscientiousness" => ["rap"] #6 random from genres in this list
  }

  def process
    twitter_profile = self.options[:twitter_profile]
    begin
      data = map_personalities_to_tags(twitter_profile)
      self.result[:data] = data

      FetchRecommendMusicJob.perform_later(twitter_profile_id: twitter_profile.id, data: data)
      self.result.success!
    rescue Exception => e
      self.result.failure!
    end
  end

  def map_personalities_to_tags(twitter_profile)
    data = []
    personalities = twitter_profile.personalities.order("raw_score DESC").limit(3)
    personalities.each do |personality|
      tags = PERSONALITY_TO_MUSIC_TAG[personality.name]
      next if tags.blank?
      data << { personality_id: personality.id, tags: tags }
    end
    data
  end
end
