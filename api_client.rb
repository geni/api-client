require 'rubygems'
require 'sinatra'
require 'oauth2'
require 'json'
require 'pp'
require 'liquid'

$LOAD_PATH.unshift File.dirname(File.expand_path(__FILE__)) + '/lib'
require 'family'

# please go to http://www.geni.com/apps to obtain an app_id and app_secret
APP_ID     = '<app-id>'
APP_SECRET = '<app-secret>'
SITE       = 'https://www.geni.com'


get '/' do
  liquid :index
end

get '/auth' do
  redirect client.web_server.authorize_url(
    :redirect_uri => redirect_uri
  )
end

get '/callback' do
  token = client.web_server.get_access_token(params[:code], :redirect_uri => redirect_uri.tap{|ii| puts ii})
  response.set_cookie('token', :value => token.token)
  redirect '/family'
end

get '/family' do
  redirect '/' unless request.cookies['token']

  begin
    token   = OAuth2::AccessToken.new(client, request.cookies['token'])
    node_id = "-#{params[:node_id]}" if params[:node_id]
    family  = Family.new(token.get("/api/profile#{node_id}/immediate-family"))
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

class OAuth2::AccessToken
  # fix bug introduced in https://github.com/intridea/oauth2/commit/607af1ca78fa20b796de6260aa143117bc712551
  def request(verb, path, params = {}, headers = {})
    params = params.merge token_param => @token
    headers = headers.merge 'Authorization' => "Token token=\"#{@token}\""
    @client.request(verb, path, params, headers)
  end
end
