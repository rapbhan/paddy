class FeedController < ApplicationController

def index
	url="http://news.google.co.in/?output=rss"
	Feed.create_from_url(url)
end

end
