class FacebookGraph
  def initialize(token)
    @koala = Koala::Facebook::API.new(token)
  end

  def user_artists
    artists_pages
    .map { |artist| artist['name'] }
    .compact
    .map { |genre| genre.downcase }
    .uniq
  end

  def user_genres
    artists_pages
    .map { |artist| artist['genre'] }
    .compact
    .map { |genre| genre.downcase }
    .uniq
  end

  def artists_pages
    category_whitelist = ['Artist', 'Musician/Band']
    @koala.get_connections("me", "likes", {fields: ['name', 'category', 'genre']})
    .select { |page| category_whitelist.include? page['category'] }
  end
end