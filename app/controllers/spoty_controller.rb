class SpotyController < ActionController::Base
  def index
    spoty = Spoty.new
    @fb_genres = ['rock', 'blues', 'reggaeton']
    @fb_artists = ['rock', 'blues', 'reggaeton']
    @fb_statuses = ['happy']
    @token = spoty.gen_spotify_token
    @songs = spoty.get_songs(@token, @fb_genres, @fb_artists, @fb_statuses)
  end
end
