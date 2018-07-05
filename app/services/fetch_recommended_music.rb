class FetchRecommendedMusic < BaseService
  PERSONALITY_TO_MUSIC_TAG = {
    "Openness" => ["Classical", "blues", "jazz", "folk"],
    "Extraversion" => ["rap", "hip hop", "soul", "electronic", "dance"],
    "Agreeableness" => ["upbeat"], #  3 top from upbeat, 3 random from genres on this list.
    "Neuroticism" => ["Country", "pop"]
    "Conscientiousness" => [], #6 random from genres in this list
  }

  def process
    twitter_profile = self.options[:twitter_profile]

    # http://ws.audioscrobbler.com/2.0/?method=tag.gettopalbums&tag=Country&api_key=c47911e7b791ea40072ba2ac514bd097&format=json
    begin

      url = "http://ws.audioscrobbler.com/2.0/"
      params = {
        "method" => "tag.gettopalbums",
        "tag" => "Country",
        "api_key" => ::AppConfig["lastfm_key"],
        "format" => "json"
      }
      resource = RestClient::Resource.new("#{url}?#{params.to_query}")
      response = resource.get

      self.result.success!
    rescue Exception => e
      self.result.failure!
    end
  end
end