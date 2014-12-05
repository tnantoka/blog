require 'rails_helper'

feature "Versions", :type => :feature do
  with_versioning do
    let(:user) { create(:user) }
    before { sign_in(user) }
    let(:post) { create(:post, title: 'first') }
    let!(:versions) do
      post.update!(title: 'second')
      post.update!(title: 'third')
      post.versions
    end 
    let(:version) { versions.last }

    feature 'index' do
      scenario do
        visit post_versions_path(post.id)
        expect(current_path).to eq post_versions_path(post.id)
        versions.each do |version|
          expect(page).to have_content(version.reify.title)
        end
      end
    end

    feature 'CRUD' do
      scenario 'show' do
        visit post_version_path(post.id, version)
        expect(current_path).to eq post_version_path(post.id, versions.last)
        expect(page).to have_content(version.reify.title)
        expect(page).to have_content(version.reify.content)
      end
    end
  end
end
