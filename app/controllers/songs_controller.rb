class SongsController < ApplicationController
  def index
    fb_graph = current_user.fb_graph(session['facebook_access_token'])
    byebug
  end
end