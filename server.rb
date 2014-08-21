require 'sinatra'
require 'CSV'

def import_csv(filename)
  articles = []
  CSV.foreach(filename, headers: true) do |row|
    articles << row.to_hash
  end
  articles
end

get '/slackernews' do
  erb :index
end

get '/slackernews/submit' do
  # @articles = import_csv('slacker_news.csv')
  erb :submit
end


post '/slackernews/submit' do
  title = params['title']
  des = params['content']
  url = params['url']

  File.open('slacker_news.csv','a') do |file|
    file.puts("#{title},#{url}, #{des}")
  end
  redirect'/slackernews/submit'
end

get '/slackernews/submit/yourarticles' do
  @articles = import_csv('slacker_news.csv')
  erb :your_articles
end




set :views, File.dirname(__FILE__) + '/views'
set :public_folder, File.dirname(__FILE__) + '/public'
