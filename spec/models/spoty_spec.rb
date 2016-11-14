require 'rails_helper'

RSpec.describe Spoty, type: :model do
  context "Probando el token de acceso a la API de Spotify" do
    it "El token no es nulo" do
      spoty = Spoty.new
      token = spoty.gen_spotify_token
      expect(token != nil)
    end
  end
end

RSpec.describe Spoty, type: :model do
  context "Probando el token de acceso a la API de Spotify" do
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
      songs = spoty.gen_spotify_token
      expect(songs != nil)
    end
  end
end
