class SpotyController < ApplicationController
  before_action :authenticate_user!
  before_action :set_fb_graph

  def index
    spoty = Spoty.new

    # Facebook data seeds
    # fb_genres = ['rock', 'salsa', 'reggaeton']
    # fb_artists = ['slipknot', 'marc', 'farruko']

    # fb_genres = current_user.genres
    # fb_artists = current_user.artists
    fb_statuses = ['happy']

    # Spotify query
    @songs = spoty.get_songs(fb_genres, fb_artists, fb_statuses)
  end

  private
    def set_fb_graph
      current_user.set_fb_graph(session['fb_access_token'])
    end
end
