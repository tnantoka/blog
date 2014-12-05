require 'rails_helper'

feature "Sessions", :type => :feature do
  let(:user) { create(:user) }

  feature 'create' do
    scenario do
      sign_in(user)
      expect(page).to have_content(I18n.t('layouts.application.sign_out'))
    end
  end

  feature 'destroy' do
    scenario do
      sign_in(user)
      sign_out
      expect(page).to have_content(I18n.t('layouts.application.admin'))
    end
  end
end
