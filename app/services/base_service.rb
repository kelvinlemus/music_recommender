class BaseService
  class Result < Hash
    def success!
      @success = true
    end

    def success?
      @success
    end

    def failure!
      @failure = true
    end

    def failure?
      @failure
    end
  end

  attr_accessor :options, :result

  def initialize(options={})
    self.options = options
    self.result = Result.new
  end

  def self.call(options)
    instance = self.new(options)
    instance.process
    instance.result
  end

private
  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ::AppConfig["twitter_consumer_key"]
      config.consumer_secret     = ::AppConfig["twitter_consumer_secret"]
      config.access_token        = ::AppConfig["twitter_access_token"]
      config.access_token_secret = ::AppConfig["twitter_access_token_secret"]
    end
  end
end
