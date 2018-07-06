class FetchRecommendMusicJob < ApplicationJob
  queue_as :default

  def perform(args)
    twitter_profile = TwitterProfile.find(args[:twitter_profile_id])
    recommendations = []
    data = args[:data]
    data.each do |_data|
      _data[:tags].each do |tag|
        response = fetch_albums_for(tag)
        next if response.nil?
        recommendations << {
          personality_id: _data[:personality_id],
          tag: tag,
          response: response["albums"]["album"][0]
        }
      end
    end
    save_albums_for(twitter_profile, recommendations)
    twitter_profile.update_attribute(:music_recommender_status, "processed")
  end

  def fetch_albums_for(tag)
    begin
      url = "http://ws.audioscrobbler.com/2.0/"
      params = {
        "method" => "tag.gettopalbums",
        "tag" => tag,
        "api_key" => ::AppConfig["lastfm_key"],
        "format" => "json",
        "limit" => 1
      }
      resource = RestClient::Resource.new("#{url}?#{params.to_query}")
      response = resource.get
      return JSON.parse(response.body)
    rescue Exception
      return nil
    end
  end

  def save_albums_for(twitter_profile, data)
    data.each do |_data|
      twitter_profile.recommended_musics.new.tap do |r|
        r.personality_id = _data[:personality_id]
        r.tag = _data[:tag]
        r.album_name = _data[:response]["name"]
        r.album_url = _data[:response]["url"]
        r.album_artist_name = _data[:response]["artist"]["name"]
        r.save
      end
    end
  end
end
