require 'rails_helper'

feature "Attachments", :type => :feature do
  let(:user) { create(:user) }
  before { sign_in(user) }

  feature 'index' do
    let!(:attachments) { create_list(:attachment, 3) }

    scenario do
      visit attachments_path
      expect(current_path).to eq attachments_path
      attachments.each do |attachment|
        expect(page).to have_content(attachment.file_file_name)
      end
    end
  end

  feature 'CRUD' do
    scenario 'new' do
      visit new_attachment_path
      attach_file 'attachment[file]', Rails.root.join('spec/fixtures/image.png')
      click_on I18n.t('helpers.submit.create', model: Attachment.model_name.human)
      expect(current_path).to eq attachments_path
      expect(page).to have_content('image.png')
    end
    scenario 'destroy' do
      attachment = create(:attachment, :image)
      visit attachments_path
      click_on I18n.t('attachments.index.delete')
      expect(current_path).to eq attachments_path
      expect(page).to_not have_content(attachment.file_file_name)
    end
  end
end
