require 'sinatra'
require 'open-uri'
require 'rss'

get '/hello' do
  @title="My First Sinatra App"
  @greeting="Hello world! The time is now #{Time.now}"
  erb :hello 
end




get %r{/twitter/([\w]+)} do
  feedurl="http://search.twitter.com/search.rss?q=#{params[:captures].first}"
  feedcontent=""
  open(feedurl) do |s| feedcontent = s.read end
  rss = RSS::Parser.parse(feedcontent,false)

  @feedtitle=rss.channel.title
  @feedlink=rss.channel.link
  @feeditems=rss.channel.items
  @title="Twitter feed for " + @feedtitle

  erb :twitter

end

