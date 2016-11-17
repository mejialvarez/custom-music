require 'rails_helper'

RSpec.describe Spoty, type: :model do
  context "#gen_spotify_token" do
    it "returns not null" do
      spoty = Spoty.new
      token = spoty.gen_spotify_token
      expect(token).to be_truthy
    end
  end

  context "#gen_spotify_token" do
    it "returns 86 chars" do
      spoty = Spoty.new
      token = spoty.gen_spotify_token
      expect(token.size).to eq 86
    end
  end

  context "#get_songs" do
    it "returns not empty" do
      spoty = Spoty.new
      genres = ['rock', 'salsa', 'reggaeton']
      artists = ['marc', 'slipknot', 'farruko']
      statuses = ['happy']
      songs = spoty.get_songs(genres, artists, statuses)
      expect(songs).to be_truthy
    end
  end

  context "#get_songs" do
    it "returns 30 songs" do
      spoty = Spoty.new
      genres = ['rock', 'salsa', 'reggaeton']
      artists = ['marc', 'slipknot', 'farruko']
      statuses = ['happy']
      songs = spoty.get_songs(genres, artists, statuses)
      expect(songs.size).to eq 30
    end
  end

  context "#get_available_genres" do
    it "returns not empty" do
      spoty = Spoty.new
      token = spoty.gen_spotify_token
      genres = spoty.get_available_genres(token)
      expect(genres).to be_truthy
    end
  end

  context "#get_available_genres" do
    it "returns 401 Unauthorized with fake token" do
      spoty = Spoty.new
      token = "errortoken"
      genres = spoty.get_available_genres(token)
      expect(genres).to eq '401 Unauthorized'
    end
  end

  context "#get_matched_genres" do
    it "returns list with one genre with match 100%" do
      spoty = Spoty.new
      genres_one = ['rock']
      genres_two = ['rock']
      genres = spoty.get_matched_genres(genres_one, genres_two)
      expect(genres[0]).to eq genres_one[0]
    end
  end

  context "#get_matched_genres" do
    it "returns list with one genre with match 90%" do
      spoty = Spoty.new
      genres_one = ['rock']
      genres_two = ['rockroll']
      genres = spoty.get_matched_genres(genres_one, genres_two)
      expect(genres[0]).to eq genres_one[0]
    end
  end

  context "#get_matched_genres" do
    it "returns empty list with match 0%" do
      spoty = Spoty.new
      genres_one = ['rock']
      genres_two = ['blues']
      genres = spoty.get_matched_genres(genres_one, genres_two)
      expect(genres.size).to eq 0
    end
  end

  context "#get_matched_artists" do
    it "returns list with one artist with match 100%" do
      spoty = Spoty.new
      artists_one = Hash.new
      artists_one['1'] = 'slipknot'
      artists_two = ['slipknot']
      artists = spoty.get_matched_artists(artists_one, artists_two)
      expect(artists[0]).to eq artists_one[0]
    end
  end

  context "#get_matched_artists" do
    it "returns list with one artist with match 90%" do
      spoty = Spoty.new
      artists_one = Hash.new
      artists_one['1'] = 'slipknottt'
      artists_two = ['slipknot']
      artists = spoty.get_matched_artists(artists_one, artists_two)
      expect(artists.size).to eq 1
    end
  end

  context "#get_matched_artists" do
    it "returns empty list with empty dictionary artists seed" do
      spoty = Spoty.new
      artists_one = Hash.new
      artists_two = ['slipknot']
      artists = spoty.get_matched_artists(artists_one, artists_two)
      expect(artists.size).to eq 0
    end
  end

  context "#get_matched_artists" do
    it "returns empty list with empty list artists seed" do
      spoty = Spoty.new
      artists_one = Hash.new
      artists_one['1'] = 'slipknot'
      artists_two = ['']
      artists = spoty.get_matched_artists(artists_one, artists_two)
      expect(artists.size).to eq 0
    end
  end
end
