require 'rails_helper'

feature "Home", :type => :feature do
  feature 'index' do
    let!(:published_posts) { create_list(:post, 3, :published) }
    let!(:draft_posts) { create_list(:post, 3, :draft) }
    let!(:template_posts) { create_list(:post, 3, :template) }
    scenario do
      visit root_path
      expect(current_path).to eq root_path
      published_posts.each do |post|
        expect(page).to have_content(post.title)
        expect(page).to_not have_content(post.content)
      end
      draft_posts.each do |post|
        expect(page).to_not have_content(post.title)
        expect(page).to_not have_content(post.content)
      end
    end
  end
end
