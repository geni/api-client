require 'rubygems'
require 'sinatra'
require 'oauth2'
require 'json'

APP_ID     = 'uOfqRRZYc3iyva3nweWS'
APP_SECRET = '7pwWsVWjEeCixg75EHoyHHqLVRHIrXwgm4Fxkf8X'
SITE       = 'https://qa.geni.com'

def client
  OAuth2::Client.new(APP_ID, APP_SECRET, :site => SITE, :parse_json => true)
end

def redirect_uri
  uri = URI.parse(request.url)
  uri.path = '/callback'
  uri.query = nil
  uri.to_s
end

get '/' do
  liquid :index
end

get '/auth' do
  redirect client.web_server.authorize_url(
    :redirect_uri => redirect_uri
  )
end

get '/callback' do
  token = client.web_server.get_access_token(params[:code], :redirect_uri => redirect_uri)
  token.get('/api/profiles').inspect
end

