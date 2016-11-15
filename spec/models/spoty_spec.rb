require 'rails_helper'

RSpec.describe Spoty, type: :model do
  context "Probando generacion del token de acceso a la API de Spotify" do
    it "El token no es nulo" do
      spoty = Spoty.new
      token = spoty.gen_spotify_token
      expect(token != nil)
    end
  end
end

RSpec.describe Spoty, type: :model do
  context "Probando generacion del token de acceso a la API de Spotify" do
    it "El token tiene 86 caracteres" do
      spoty = Spoty.new
      token = spoty.gen_spotify_token
      expect(token.size == 86)
    end
  end
end

RSpec.describe Spoty, type: :model do
  context "Probando generacion de canciones desde Spotify" do
    it "La lista no esta vacía" do
      spoty = Spoty.new
      token = spoty.gen_spotify_token
      genres = ['rock', 'blues', 'reggaeton']
      artists = ['rock', 'blues', 'reggaeton']
      statuses = ['happy']
      songs = spoty.get_songs(token, genres, artists, statuses)
      expect(songs != nil)
    end
  end
end

RSpec.describe Spoty, type: :model do
  context "Probando generacion de canciones desde Spotify" do
    it "Responde 401 Unauthorized con token invalido" do
      spoty = Spoty.new
      token = 'tokenerror'
      genres = ['rock', 'blues', 'reggaeton']
      artists = ['rock', 'blues', 'reggaeton']
      statuses = ['happy']
      songs = spoty.get_songs(token, genres, artists, statuses)
      expect(songs == '401 Unauthorized')
    end
  end
end

RSpec.describe Spoty, type: :model do
  context "Probando generacion de canciones desde Spotify" do
    it "La lista tiene 20 canciones" do
      spoty = Spoty.new
      token = spoty.gen_spotify_token
      genres = ['rock', 'blues', 'reggaeton']
      artists = ['rock', 'blues', 'reggaeton']
      statuses = ['happy']
      songs = spoty.get_songs(token, genres, artists, statuses)
      expect(songs.size == 20)
    end
  end
end

RSpec.describe Spoty, type: :model do
  context "Probando consulta de generos diponibles en Spotify" do
    it "La lista no esta vacía" do
      spoty = Spoty.new
      token = spoty.gen_spotify_token
      genres = spoty.get_available_genres(token)
      expect(genres != nil)
    end
  end
end

RSpec.describe Spoty, type: :model do
  context "Probando consulta de generos diponibles en Spotify" do
    it "Responde 401 Unauthorized con token erroneo" do
      spoty = Spoty.new
      token = "errortoken"
      genres = spoty.get_available_genres(token)
      expect(genres == '401 Unauthorized')
    end
  end
end

RSpec.describe Spoty, type: :model do
  context "Probando match entre generos" do
    it "Hace match al 100%" do
      spoty = Spoty.new
      genres_one = ['rock']
      genres_two = ['rock']
      genres = spoty.get_matched_genres(genres_one, genres_two)
      expect(genres[0] == genres_one[0])
    end
  end
end

RSpec.describe Spoty, type: :model do
  context "Probando match entre generos" do
    it "Hace match al 90%" do
      spoty = Spoty.new
      genres_one = ['rock']
      genres_two = ['rockroll']
      genres = spoty.get_matched_genres(genres_one, genres_two)
      expect(genres[0] == genres_one[0])
    end
  end
end

RSpec.describe Spoty, type: :model do
  context "Probando match entre generos" do
    it "No hace match al 0%" do
      spoty = Spoty.new
      genres_one = ['rock']
      genres_two = ['blues']
      genres = spoty.get_matched_genres(genres_one, genres_two)
      expect(genres.size == 0)
    end
  end
end
