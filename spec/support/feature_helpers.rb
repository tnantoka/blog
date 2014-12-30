module FeatureHelpers
  def sign_in(user)
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: 'password'
    click_on I18n.t('devise.sessions.new.log_in')
  end

  def sign_out
    visit root_path
    click_on I18n.t('layouts.application.sign_out')
  end
end

