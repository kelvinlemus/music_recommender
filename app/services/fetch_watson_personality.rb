class FetchWatsonPersonality < BaseService

  def process
    params = self.options[:params]

    begin
      url = "https://gateway.watsonplatform.net/personality-insights/api/v3/profile?version=2017-10-13&consumption_preferences=true&raw_scores=true"
      headers = { "Accept" => "application/json" }
      resource = RestClient::Resource.new(url, user: ::AppConfig["watson_user"], password: ::AppConfig["watson_password"], headers: headers)
      response = resource.post(params.to_json, content_type: "application/json")

      personalities = get_personalities(response)
      twitter_profile = self.options[:twitter_profile]
      twitter_profile.personalities.create(personalities)

    rescue Exception => e
      self.result.failure!
    end

  end

private
  def get_personalities(response)
    parsed_response = JSON.parse(response)
    personalities = select_valid_personalities(parsed_response["personality"]).map do |obj|
      { name: obj["name"], raw_score: obj["raw_score"] }
    end

    if personalities.blank?
      personalities = default_personalities
    end
    personalities
  end

  def default_personalities
    [
      { name: "Openness", raw_score: 0.60 },
      { name: "Conscientiousness", raw_score: 0.60 },
      { name: "Extraversion", raw_score: 0.60 }
    ]
  end

  def select_valid_personalities(personalities)
    personalities.select {|obj| obj["raw_score"] > 0.5}
  end
end
