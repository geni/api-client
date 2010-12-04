require 'rubygems'
require 'sinatra'
require 'oauth2'
require 'json'
require 'pp'

$LOAD_PATH.unshift File.dirname(File.expand_path(__FILE__)) + '/lib'
require 'family'

APP_ID     = 'uOfqRRZYc3iyva3nweWS'
APP_SECRET = '7pwWsVWjEeCixg75EHoyHHqLVRHIrXwgm4Fxkf8X'
SITE       = 'https://qa.geni.com'

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
  response.set_cookie('token', :value => token.token)
  redirect '/family'
end

get '/family' do
  redirect '/' unless request.cookies['token']

  token  = OAuth2::AccessToken.new(client, request.cookies['token'])
  family = Family.new(token.get("/api/profiles/immediate_family/#{params[:pid]}")) if params[:pid]
  liquid :family, :locals => {:handprint => (family && family.handprint)} 
end

def client
  OAuth2::Client.new(APP_ID, APP_SECRET,
    :site => SITE,
    :parse_json => true,
    :access_token_path => '/oauth/token'
  )
end

def redirect_uri
  uri = URI.parse(request.url)
  uri.path = '/callback'
  uri.query = nil
  uri.to_s
end