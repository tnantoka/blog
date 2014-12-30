require 'rails_helper'

feature "Comments", :type => :feature do
  feature 'CRUD' do
    let(:post) { create(:post, :published) }

    before do
      sign_in_with_github(post)
    end
    
    feature 'create' do
      scenario 'valid' do
        new_comment = build(:comment)
        fill_in 'comment[body]', with: new_comment.body
        click_on I18n.t('helpers.submit.create', model: Comment.model_name.human)
        expect(current_path).to eq post_path(post)
        expect(page).to have_content(new_comment.body)
      end
      scenario 'invalid' do
        click_on I18n.t('helpers.submit.create', model: Comment.model_name.human)
        expect(current_path).to eq post_comments_path(post)
      end
    end
  end
end


