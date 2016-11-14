class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # require 'rspotify'
  require 'rest-client'
  require "base64"
  # acousticness 0.0 - 1.0
  # danceability 0.0 - 1.0
  # energy 0.0 - 1.0
  # instrumentalness 0.0 - 1.0
  # liveness 0.0 - 1.0
  # loudness 0.0 - 1.0
  # popularity 0.0 - 0.1
  # speechiness 0.0 - 0.1
  # tempo 0.0 - 0.1
  # valence 0.0 - 0.1 (positivismo)

  # headers = "{Authorization: Bearer "+SPOTIFY_TOKEN+"}"
  # base_url = "https://api.spotify.com/v1/recommendations"
  CLIENT_SECRET_SPOTIFY_APP_B64 = "NTE1MzBhNWFmZDAyNGRiMTg5ZTZhYWVmZjNmMGJhY2Y6MzcxNjk4OGY3Zjg0NDE0MzhlYmNkNGY0OTJmZjE0Y2Q="
  def spoty
    # genera un nuevo token en Spotify con las credenciales de la app creada como developer
    @res_token = RestClient.post('https://accounts.spotify.com/api/token', {:grant_type => 'client_credentials'},{:Authorization => 'Basic NTE1MzBhNWFmZDAyNGRiMTg5ZTZhYWVmZjNmMGJhY2Y6MzcxNjk4OGY3Zjg0NDE0MzhlYmNkNGY0OTJmZjE0Y2Q='})
    @token = ActiveSupport::JSON.decode(@res_token)["access_token"]
    # consulta cancionas basadas en un genero y los parametros listado arriba
    @res = RestClient.get 'https://api.spotify.com/v1/recommendations?seed_genres=rock', {Authorization: 'Bearer '+@token}
  end

  def new_session_path(scope)
    new_user_session_path
  end
end
