require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
  let(:post_id) { create(:post, :published).id }

  context 'signed in' do
    let(:user) { create(:user) }
    describe '#preview' do
      before { sign_in(user) }
      it 'responds json' do
        post :preview, post: { title: 'title', content: '# Header' }
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json['title']).to eq('title')
        expect(json['content']).to eq("<h1 id=\"header\">Header</h1>\n")
        expect(json['count']).to eq(6)
      end
    end
    describe '#index' do
      before { sign_in(user) }
      before { create_list(:post, 10) }
      it 'responds atom' do
        get :index, format: :atom
        expect(response.status).to eq(200)
        expect(response).to render_template('posts/index')
      end
    end
    describe '#show' do
      before { sign_in(user) }
      before { create_list(:post, 10) }
      it 'responds md' do
        get :show, id: post_id, format: :md
        expect(response.status).to eq(200)
        expect(response).to render_template('posts/show')
      end
    end
  end

  context 'signed out' do
    describe '#index' do
      it 'responds 200' do
        get :index
        expect(response.status).to eq(200)
      end
    end

    describe '#show' do
      it 'responds 200' do
        get :show, id: post_id
        expect(response.status).to eq(200)
      end
    end

    describe '#new' do
      it 'redirects to sign in' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe '#edit' do
      it 'redirects to sign in' do
        get :edit, id: post_id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe '#create' do
      it 'redirects to sign in' do
        post :create
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe '#update' do
      it 'redirects to sign in' do
        patch :update, id: post_id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe '#destroy' do
      it 'redirects to sign in' do
        delete :destroy, id: post_id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe '#search' do
      it 'responds 200' do
        get :search, q: 'a'
        expect(response.status).to eq(200)
      end
    end

    describe '#preview' do
      it 'redirects to sign in' do
        post :preview, id: post_id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe '#published' do
      it 'redirects to sign in' do
        get :published
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe '#draft' do
      it 'redirects to sign in' do
        get :draft
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe '#template' do
      it 'redirects to sign in' do
        get :template
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
