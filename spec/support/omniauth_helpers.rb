module OmniAuthHelpers
  def auth_hash
    OmniAuth::AuthHash.new({
      provider: 'github',
      uid: '123545',
      info: {
        nickname: 'name',
        urls: {
          GitHub: 'http://example.com/'
        }
      },
      extra: {
        raw_info: {}
      }
    })
  end

  def sign_in_with_github(post)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = auth_hash
    visit post_path(post)
    click_on I18n.t('posts.show.sign_in_to_comment')
  end
end

