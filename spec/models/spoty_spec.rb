require 'rails_helper'

RSpec.describe Spoty, type: :model do
  context "Probando generacion del token de acceso a la API de Spotify" do
    it "El token no es nulo" do
      spoty = Spoty.new
      token = spoty.gen_spotify_token
      expect(token).to be_truthy
    end
  end
end

RSpec.describe Spoty, type: :model do
  context "Probando generacion del token de acceso a la API de Spotify" do
    it "El token tiene 86 caracteres" do
      spoty = Spoty.new
      token = spoty.gen_spotify_token
      expect(token.size).to eq 86
    end
  end
end

RSpec.describe Spoty, type: :model do
  context "Probando generacion de canciones desde Spotify" do
    it "La lista no esta vacía" do
      spoty = Spoty.new
      genres = ['rock', 'salsa', 'reggaeton']
      artists = ['marc', 'slipknot', 'farruko']
      statuses = ['happy']
      songs = spoty.get_songs(genres, artists, statuses)
      expect(songs).to be_truthy
    end
  end
end

RSpec.describe Spoty, type: :model do
  context "Probando generacion de canciones desde Spotify" do
    it "La lista tiene 30 canciones" do
      spoty = Spoty.new
      genres = ['rock', 'salsa', 'reggaeton']
      artists = ['marc', 'slipknot', 'farruko']
      statuses = ['happy']
      songs = spoty.get_songs(genres, artists, statuses)
      expect(songs.size).to eq 30
    end
  end
end

RSpec.describe Spoty, type: :model do
  context "Probando consulta de generos diponibles en Spotify" do
    it "La lista no esta vacía" do
      spoty = Spoty.new
      token = spoty.gen_spotify_token
      genres = spoty.get_available_genres(token)
      expect(genres).to be_truthy
    end
  end
end

RSpec.describe Spoty, type: :model do
  context "Probando consulta de generos diponibles en Spotify" do
    it "Responde 401 Unauthorized con token erroneo" do
      spoty = Spoty.new
      token = "errortoken"
      genres = spoty.get_available_genres(token)
      expect(genres).to eq '401 Unauthorized'
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
      expect(genres[0]).to eq genres_one[0]
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
      expect(genres[0]).to eq genres_one[0]
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
      expect(genres.size).to eq 0
    end
  end
end

RSpec.describe Spoty, type: :model do
  context "Probando match entre artistas" do
    it "Hace match al 100%" do
      spoty = Spoty.new
      artists_one = Hash.new
      artists_one['1'] = 'slipknot'
      artists_two = ['slipknot']
      artists = spoty.get_matched_artists(artists_one, artists_two)
      expect(artists[0]).to eq artists_one[0]
    end
  end
end

RSpec.describe Spoty, type: :model do
  context "Probando match entre artistas" do
    it "Hace match al 90%" do
      spoty = Spoty.new
      artists_one = Hash.new
      artists_one['1'] = 'slipknottt'
      artists_two = ['slipknot']
      artists = spoty.get_matched_artists(artists_one, artists_two)
      expect(artists.size).to eq 1
    end
  end
end

RSpec.describe Spoty, type: :model do
  context "Probando match entre artistas" do
    it "Retorna lista vacía si recibe diccionario vacío" do
      spoty = Spoty.new
      artists_one = Hash.new
      artists_two = ['slipknot']
      artists = spoty.get_matched_artists(artists_one, artists_two)
      expect(artists.size).to eq 0
    end
  end
end

RSpec.describe Spoty, type: :model do
  context "Probando match entre artistas" do
    it "Retorna lista vacía si recibe lista vacía" do
      spoty = Spoty.new
      artists_one = Hash.new
      artists_one['1'] = 'slipknot'
      artists_two = ['']
      artists = spoty.get_matched_artists(artists_one, artists_two)
      expect(artists.size).to eq 0
    end
  end
end
