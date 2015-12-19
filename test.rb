ENV['RACK_ENV'] = 'test'
require './app'
require 'minitest/autorun'
require 'rack/test'
require 'tilt/erb'
#require_relative 'app.rb'


class MyTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
  

  def test_for_index_erb
    get '/'
    assert last_response.ok?
    assert last_response.body.include?('slideshowimages("mm.png","rules2.png","board.png")')
    assert last_response.body.include?('slideshowlinks("http://localhost:4567/minedminds","http://localhost:4567/rules","http://localhost:4567/playgame")')
  end

  def test_it_redirects_to_rules_erb
    get '/rules'
    assert last_response.ok?
    assert last_response.body.include?('href="javascript:gotoshow()"><img src="rules2.png" ')
    assert last_response.body.include?('"https://en.wikipedia.org/wiki/Tic-tac-toe#Strategy"')
    assert last_response.body.include?('class="active"href="http://localhost:4567/rules">Rules')
    assert_equal "http://example.org/rules",last_request.url
  end

  
  def test_it_redirects_to_playgame_erb
    get '/playgame'
    assert last_response.ok?
    assert_equal "http://example.org/playgame",last_request.url
    assert last_response.body.include?('class="active"href="http://localhost:4567/playgame">Play Game')
    assert last_response.body.include?('slideshowimages("board.png")')
  end

  def test_it_redirects_to_minedminds_erb
    get '/minedminds'
    assert last_response.ok?
    assert_equal "http://example.org/minedminds",last_request.url
    assert last_response.body.include?('class="active" href="http://localhost:4567/minedminds">Mined Minds')
    assert last_response.body.include?('img src="banner2.jpg"')
    #assert_equal '"https://www.facebook.com/MinedMinds"', last_response.body
  end

  def test_for_pictures1
    get '/minedminds'
    pictures = load_pictures
    assert pictures.length > 0, "There are no pictures" #message displayed when assertion is false
  end
  
  def test_for_pictures2
    get '/playgame'
    pictures = load_pictures
    assert pictures.length > 0, "There are no pictures" #message displayed when assertion is false 
  end

  def test_for_pictures3
    get '/rules'
    pictures = load_pictures
    assert pictures.length > 0, "There are no pictures" #message displayed when assertion is false 
  end

  def test_for_pictures4
    get '/index'
    pictures = load_pictures
    assert pictures.length > 0, "There are no pictures" #message displayed when assertion is false 
  end

  def test_for_home_index
    get '/'
    assert last_response.ok?
    assert last_response.body.include?("banner2.jpg")
  end


end

class NotFound < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
  
  def test_it_is_a_404 #does root exist??
    get '/starter_page'
    assert_equal 404, last_response.status
  end

end 