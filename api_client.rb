require 'rubygems'
require 'sinatra'
require 'oauth2'
require 'json'
require 'pp'
require 'liquid'

$LOAD_PATH.unshift File.dirname(File.expand_path(__FILE__)) + '/lib'
require 'family'

APP_ID     = 'OGVCFRGWsyZSpLvYSQqxS5v4O4GESIVYpENIya8n'
APP_SECRET = 'asT35rBEXnWC54fa2C3IAPOeNMnpVUvkES49RZLE'
SITE       = 'https://stage.geni.com'

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

  begin
    token  = OAuth2::AccessToken.new(client, request.cookies['token'])
    pid    = "-#{params[:pid]}" if params[:pid]
    family = Family.new(token.get("/api/profile#{pid}/immediate-family"))
    liquid :family, :locals => {:handprint => (family && family.handprint), :focus => (family && family.focus_name) } 
  rescue OAuth2::HTTPError => e
    body = JSON.parse(e.response.body)
    if body.is_a?(Hash) and body.key?('error')
      message = body['error']['message']
    end
    liquid :family, :locals => {:error => e.message, :message => message}
  end
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
