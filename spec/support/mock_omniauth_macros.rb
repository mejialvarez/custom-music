module MockOmniauthMacros
  def mock_auth_facebook
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      provider: 'facebook',
      uid: '12345',
      info: {
        name: 'mockuser',
        image: 'mock_user_thumbnail_url'
      },
      credentials: {
        token: 'token',
      }
    })
  end
end