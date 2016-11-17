class SpotyController < ActionController::Base
  # before_action :authenticate_user!

  def index
    spoty = Spoty.new

    # Facebook data seeds
    fb_genres = ['rock']
    fb_artists = ['slipknot']
    fb_statuses = ['happy']

    # Spotify query
    @songs = spoty.get_songs(fb_genres, fb_artists, fb_statuses)
  end

end
