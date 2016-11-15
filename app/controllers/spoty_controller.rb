class SpotyController < ActionController::Base
  # before_action :authenticate_user!

  def index
    spoty = Spoty.new
    token = spoty.gen_spotify_token

    # Facebook data seeds
    fb_genres = ['salsa']
    fb_artists = ['slipknot']
    fb_statuses = ['happy']

    # Spotify data seeds
    spoty_genres = spoty.get_available_genres(token)
    spotify_artists = spoty.get_artists_ids(token, fb_artists)
    @genres = spoty.get_matched_genres(spoty_genres, fb_genres)
    @artists = spoty.get_matched_artists(spotify_artists, fb_artists)

    # Spotify query
    @songs = spoty.get_songs(token, @genres, @artists, fb_statuses)
  end

end
