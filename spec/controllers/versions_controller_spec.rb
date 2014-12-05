require 'rails_helper'

RSpec.describe VersionsController, :type => :controller do
  with_versioning do
    context 'signed out' do
      let!(:version) { 
        post = create(:post, :published)
        post.update(title: 'updated') 
        post.versions.last
      }
      describe '#index' do
        it 'responds 200' do
          get :index, post_id: version.item_id
          expect(response.status).to eq(200)
        end
      end

      describe '#show' do
        it 'responds 200' do
          get :show, post_id: version.item_id, id: version.id
          expect(response.status).to eq(200)
        end
      end
    end
  end
end
