module LoginMacros
  def login
    visit new_user_session_path 
    mock_auth_facebook
    find('#sign-in-fb').click
  end
end