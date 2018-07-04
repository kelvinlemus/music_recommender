class BaseService
  attr_accessor :params, :result

  def initialize(options={})
    self.options = options
    self.result = {}
  end

  def self.call(options)
    instance = self.new(options)
    instance.process
    instance.result
  end

private
  def twitter_client
    # https://apps.twitter.com/app/15446011/keys
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = "bU4qomX1FzuxEmQmpgXd3ylpZ"
      config.consumer_secret     = "MGBbS9C1HHVhbIMuJVXZY3QQF6QKnUfEHe4lPzpMfmNp5LNp65"
      config.access_token        = "1672449872-2Wt30x2Fcpr90kAoWtqHJY1ULp1WWjtBh0ZBlFp"
      config.access_token_secret = "3tdrKcQCoErNED0wbyJHSb6gXs7XNOluGEP6jXeIcFj84"
    end
  end
end