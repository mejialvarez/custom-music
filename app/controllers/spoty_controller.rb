class SpotyController < ActionController::Base
  before_action :authenticate_user!

  def index
    spoty = Spoty.new
    @token = spoty.gen_spotify_token
    @spoty_genres = spoty.get_available_genres(@token)
    @fb_genres = ['pop']
    @genres = spoty.get_matched_genres(@spoty_genres, @fb_genres)
    @fb_artists = ['rock', 'blues', 'reggaeton']
    @fb_statuses = ['happy']
    @songs = spoty.get_songs(@token, @genres, @fb_artists, @fb_statuses)
  end
end
