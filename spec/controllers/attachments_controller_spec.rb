require 'rails_helper'

RSpec.describe AttachmentsController, :type => :controller do
  context 'signed in' do
    let(:user) { create(:user) }
    describe '#create' do
      before { sign_in(user) }
      it 'responds json' do
        post :create, attachment: { file: fixture_file_upload('image.png', 'image/png') }, format: :json
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(URI.parse(json['path']).path).to eq(URI.parse(Attachment.last.file.url).path)
        expect(json['is_image']).to eq(true)
        expect(json['name']).to eq('image.png')
      end
    end
  end

  context 'signed out' do
    let(:attachment_id) { create(:attachment, :image).id }
    describe '#index' do
      it 'redirects to sign in' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe '#new' do
      it 'redirects to sign in' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe '#destroy' do
      it 'redirects to sign in' do
        delete :destroy, id: attachment_id
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
