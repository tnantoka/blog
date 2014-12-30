require 'rails_helper'

feature "Identities", :type => :feature do
  let(:user) { create(:user) }

  let(:post) { create(:post, :published) }
  feature 'create' do
    scenario do
      sign_in_with_github(post)
      expect(page).to have_content(I18n.t('layouts.application.sign_out'))
    end
  end

  feature 'destroy' do
    scenario do
      sign_in_with_github(post)
      click_on I18n.t('layouts.application.sign_out')
      expect(page).to have_content(I18n.t('posts.show.sign_in_to_comment'))
    end
  end
end
