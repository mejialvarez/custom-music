require 'spec_helper'
require 'facebook_graph'

describe FacebookGraph do
  let :fb_graph do
    FacebookGraph.new('token')
  end

  describe "#user_artists" do
    before(:each) do
      stub_request(:get, "https://graph.facebook.com/v2.0/me/likes?access_token=token&fields=name,category,genre")
      .with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'})
      .to_return(:status => 200, :body => "{\"data\":[{\"name\":\"Steve Aoki\",\"category\":\"Musician\\/Band\",\"genre\":\"Electro\\/Indie\",\"id\":\"1\"}]}", :headers => {})
    end

    it 'returns an artists array' do
      expect(fb_graph.user_artists).to eq(['steve aoki'])
    end

    it 'returns the size artists' do
      expect(fb_graph.user_artists.size).to eq(1)
    end
  end

  describe "#user_genres" do
    before(:each) do
      stub_request(:get, "https://graph.facebook.com/v2.0/me/likes?access_token=token&fields=name,category,genre")
      .with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'})
      .to_return(:status => 200,
                 :body => "{\"data\":[{\"name\":\"Steve Aoki\",\"category\":\"Musician\\/Band\",\"genre\":\"Electro\\/Indie\",\"id\":\"1\"}]}",
                 :headers => {})
    end

    it 'returns an genres array'  do
      expect(fb_graph.user_genres).to eq(['electro/indie'])
    end

    it 'returns the size genres' do
      expect(fb_graph.user_genres.size).to eq(1)
    end
  end

  describe "#artists_pages" do
    before(:each) do
      stub_request(:get, "https://graph.facebook.com/v2.0/me/likes?access_token=token&fields=name,category,genre")
      .with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'})
      .to_return(:status => 200,
                 :body => "{\"data\":[{\"name\":\"Steve Aoki\",\"category\":\"Musician\\/Band\",\"genre\":\"Electro\\/Indie\",\"id\":\"1\"}, {\"name\":\"Other\",\"category\":\"Other\",\"genre\":\"Other\",\"id\":\"2\"}]}",
                 :headers => {})
    end

    it 'returns an artist pages array' do
      expect(fb_graph.artists_pages).to eq([{"name"=>"Steve Aoki", "category"=>"Musician/Band", "genre"=>"Electro/Indie", "id"=>"1"}])
    end

    it 'returns the size of artist pages' do
      expect(fb_graph.artists_pages.size).to eq(1)
    end
  end
end
