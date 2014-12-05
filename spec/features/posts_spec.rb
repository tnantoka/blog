require 'rails_helper'

feature "Posts", :type => :feature do
  let(:user) { create(:user) }
  before { sign_in(user) }

  feature 'index' do
    let!(:published_posts) { create_list(:post, 3, :published) }
    let!(:draft_posts) { create_list(:post, 3, :draft) }
    let!(:template_posts) { create_list(:post, 3, :template) }

    scenario 'all' do
      visit posts_path
      expect(current_path).to eq posts_path
      (published_posts + draft_posts + template_posts).each do |post|
        expect(page).to have_content(post.title)
      end
    end
    scenario 'published' do
      visit published_posts_path
      expect(current_path).to eq published_posts_path
      published_posts.each do |post|
        expect(page).to have_content(post.title)
      end
      (draft_posts + template_posts).each do |post|
        expect(page).to_not have_content(post.title)
      end
    end
    scenario 'draft' do
      visit draft_posts_path
      expect(current_path).to eq draft_posts_path
      draft_posts.each do |post|
        expect(page).to have_content(post.title)
      end
      (published_posts + template_posts).each do |post|
        expect(page).to_not have_content(post.title)
      end
    end
    scenario 'template' do
      visit template_posts_path
      expect(current_path).to eq template_posts_path
      template_posts.each do |post|
        expect(page).to have_content(post.title)
      end
      (published_posts + draft_posts).each do |post|
        expect(page).to_not have_content(post.title)
      end
    end
  end

  feature 'CRUD' do
    let(:post) { create(:post) }
    
    feature 'new' do
      scenario 'valid' do
        visit new_post_path
        new_post = build(:post)
        fill_in 'post[title]', with: new_post.title
        fill_in 'post[content]', with: new_post.content
        click_on I18n.t('helpers.submit.create', model: Post.model_name.human)
        expect(current_path).to eq post_path(Post.last)
        expect(page).to have_content(new_post.title)
        expect(page).to have_content(new_post.content)
      end
      scenario 'invalid' do
        visit new_post_path
        fill_in 'post[title]', with: ''
        click_on I18n.t('helpers.submit.create', model: Post.model_name.human)
        expect(current_path).to eq posts_path
      end
    end
    feature 'edit' do
      scenario 'valid' do
        visit edit_post_path(post)
        edited_post = build(:post)
        fill_in 'post[title]', with: edited_post.title
        fill_in 'post[content]', with: edited_post.content
        click_on I18n.t('helpers.submit.update', model: Post.model_name.human)
        expect(current_path).to eq post_path(post)
        expect(page).to have_content(edited_post.title)
        expect(page).to have_content(edited_post.content)
      end
      scenario 'invalid' do
        visit edit_post_path(post)
        fill_in 'post[title]', with: ''
        click_on I18n.t('helpers.submit.update', model: Post.model_name.human)
        expect(current_path).to eq post_path(post)
      end
    end
    scenario 'destroy' do
      visit post_path(post)
      click_on I18n.t('posts.post.delete')
      expect(current_path).to eq posts_path
      expect(page).to_not have_content(post.title)
    end
  end

  feature 'search' do
    let!(:posts) { create_list(:post, 10, :published) }
    let(:query) { 'a' }
    scenario do
      visit search_posts_path(q: query)
      expect(current_path).to eq search_posts_path
      posts.select { |p| p.title =~ /#{query}/ || p.content =~ /#{query}/ }.each do |post|
        expect(page).to have_content(post.title)
        expect(page).to have_content(post.content)
      end
    end
  end
 
end
