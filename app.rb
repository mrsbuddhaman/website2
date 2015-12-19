require 'sinatra'
require 'rubygems'



def load_pictures
  Dir.glob("public/*.{png,PNG,jpg,JPG}")
end

# get '/' do
   # @pictures = load_pictures
   # erb :index
# end








get '/' do
  @title = 'Welcome to Mined Minds'
  erb :index
end

get '/rules' do
  @title = 'Tic Tac Toe Rules'
  erb :rules
end

get '/playgame' do
	@title = 'Play Tic Tac Toe!'
	erb :playgame
end

get '/minedminds' do
	@title = 'Mined Minds'
	erb :minedminds
end

get '/layout' do
	erb :layout
end
