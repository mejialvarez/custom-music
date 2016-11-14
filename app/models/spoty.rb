class Spoty < ApplicationRecord

  require 'rest-client'

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

  # Genera un nuevo token en Spotify con las credenciales de la app creada como developer
  def gen_spotify_token
    @token = RestClient.post('https://accounts.spotify.com/api/token', {:grant_type => 'client_credentials'},{:Authorization => 'Basic NTE1MzBhNWFmZDAyNGRiMTg5ZTZhYWVmZjNmMGJhY2Y6MzcxNjk4OGY3Zjg0NDE0MzhlYmNkNGY0OTJmZjE0Y2Q='})
    @token = ActiveSupport::JSON.decode(@token)["access_token"]
    return @token
  end

  # Consulta canciones basadas en un genero y los parametros listado arriba
  def get_songs(token, genres, artists, statuses)
    @results = Array.new
    @songs = Array.new

    genres.each do | genre |
      @res = RestClient.get 'https://api.spotify.com/v1/recommendations?seed_genres='+genre, {Authorization: 'Bearer '+token}
      @result = ActiveSupport::JSON.decode(@res)
      @results.push(@result)
      @result['tracks'].each do |song|
        @songs.push(song['external_urls'])
      end
    end

    return @songs
  end

end
