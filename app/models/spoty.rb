class Spoty < ApplicationRecord

  require 'rest-client'
  require 'fuzzystringmatch'
  require 'uri'

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
    begin
      token = RestClient.post('https://accounts.spotify.com/api/token', {:grant_type => 'client_credentials'},{:Authorization => 'Basic '+ ENV['CLIENT_ID_SECRET_SPOTIFY_APP_B64']})
      token = ActiveSupport::JSON.decode(token)["access_token"]
    rescue Exception => e
      token = e.message
    end
    return token
  end

  # Consulta canciones basadas en un genero y los parametros listado arriba
  def get_songs(token, genres, artists, statuses)
    results = Array.new
    songs = Array.new
    genres.each do | genre |
      artists.each do |artist, name|
        begin
          res = RestClient.get 'https://api.spotify.com/v1/recommendations?seed_genres='+genre+'&seed_artists='+artist, {Authorization: 'Bearer '+token}
        rescue Exception => e
          return e.message
        end
        result = ActiveSupport::JSON.decode(res)
        results.push(result)
        results_songs = result['tracks']
        results_songs.each do |song|
          songs.push(song['id'])
        end
      end
    end
    return songs.sample(30)
  end

  # Codifica el texto para ser utilizado en URLs
  def encode_text(text)
    return URI.escape(text)
  end

  # Consulta los ids de los artistas en Spotify basado en una lista de artistas de Facebook
  def get_artists_ids(token, artists)
    artists_ids = Hash.new
    artists.each do |artist|
      artist_encoded = encode_text(artist)
      begin
        res = RestClient.get 'https://api.spotify.com/v1/search?q='+artist_encoded+'&type=artist', {Authorization: 'Bearer '+token}
        result = ActiveSupport::JSON.decode(res)
        artists_results = result['artists']['items']
        artists_results.each do |ar|
          artists_ids[ar['id']] = ar['name']
        end
      rescue Exception => e
        return e.message
      end
    end
    return artists_ids
  end

  # Consulta los generos disponibles con los que sepuede hacer consulta en Spotify
  def get_available_genres(token)
    begin
      res = RestClient.get 'https://api.spotify.com/v1/recommendations/available-genre-seeds', {Authorization: 'Bearer '+token}
      result = ActiveSupport::JSON.decode(res)
    rescue Exception
      return nil
    end
    return result['genres']
  end

  # Encuentra similitudes entre los artistas de Spotify y los de Facebook
  def get_matched_artists(spotify_artists, fb_artists)
    matched_artists = Hash.new
    spotify_artists.each do |id, name|
      fb_artists.each do |fa|
        similarity = match_text(name, fa)
        if similarity >= 0.9
          matched_artists[id] = name
        end
      end
    end
    return matched_artists
  end

  # Determina la similitud entre dos strings
  def match_text(text_one, text_two)
    compare = FuzzyStringMatch::JaroWinkler.create(:native)
    return compare.getDistance(text_one, text_two)
  end

  # Encuentra similitudes entres lo generos de Spotify y los de Facebook y retorna una lista
  def get_matched_genres(spoty_genres, fb_genres)
    genres = Array.new
    spoty_genres.each do |sg|
      fb_genres.each do |fbg|
        similarity = match_text(sg, fbg)
        if similarity >= 0.9
          genres.push(sg)
        end
      end
    end
    return genres
  end

end
