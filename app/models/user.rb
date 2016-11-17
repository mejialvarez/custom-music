class User < ApplicationRecord
  devise  :omniauthable,
          omniauth_providers: [:facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.image = auth.info.image
      session["name"]= user.name
      session["image"] = user.image
    end
  end

  def set_fb_graph(token)
    @fb_graph ||= FacebookGraph.new(token)
  end

  def genres
    @fb_graph.user_genres
  end

  def artists
    @fb_graph.user_artists
  end
end
