require 'rails_helper'

RSpec.describe LinksController, :type => :controller do
  context 'signed in' do
    let(:user) { create(:user) }
    describe '#create' do
      before { sign_in(user) }
      it 'responds json' do
        post :create, url: 'http://example.com/'
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json['title']).to eq('Example')
        expect(json['url']).to eq('http://example.com/')
      end
    end
  end

  context 'signed out' do
    describe '#create' do
      it 'redirects to sign in' do
        post :create
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
