class User < ActiveRecord::Base
	has_many :tweets

  def tweet(status)
    tweet = tweets.create!(:status => status)
    TweetWorker.perform_in(5.seconds, tweet.id)
  end

end
