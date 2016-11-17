require 'rails_helper'

RSpec.feature "Spoty", type: :feature do
  context "with Facebook access" do
    scenario "show recomiendame title" do
      stub_request(:get, "https://graph.facebook.com/v2.0/me/likes?access_token=token&fields=name,category,genre")
      .with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'})
      .to_return(:status => 200, :body => "{\"data\":[{\"name\":\"Steve Aoki\",\"category\":\"Musician\\/Band\",\"genre\":\"Electro\\/Indie\",\"id\":\"1\"}]}", :headers => {})
      login
      expect(page).to have_content 'Las recomendaciones que traemos para ti'
    end

    scenario "show songs" do
      stub_request(:get, "https://graph.facebook.com/v2.0/me/likes?access_token=token&fields=name,category,genre")
      .with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'})
      .to_return(:status => 200, :body => "{\"data\":[{\"name\":\"Steve Aoki\",\"category\":\"Musician\\/Band\",\"genre\":\"Electro\\/Indie\",\"id\":\"1\"}]}", :headers => {})
      login
      expect(page).to have_selector('.song')
    end
  end
end