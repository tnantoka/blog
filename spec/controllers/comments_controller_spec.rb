require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  let(:post_id) { create(:post, :published).id }

  context 'without identity' do
    describe '#create' do
      it 'responds 401' do
        post :create, post_id: post_id
        expect(response.status).to eq(401)
      end
    end
  end
end
