require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:new_post) { create(:post, user_id: user.id) }
  let!(:post_params) { attributes_for(:post, user_id: user.id) }

  before do |example|
    unless example.metadata[:skip_before_action]
      login_as user
    end
  end

  describe 'GET #index' do
    context 'ログインユーザーの場合' do
      it '自分の記事の一覧ページを見ることができる' do
        get user_posts_path(user_id: user.id)
        expect(response).to have_http_status(:ok)
      end

      it '別ユーザーの記事一覧を見ることができる' do
        get user_posts_path(user_id: other_user.id)
        expect(response).to have_http_status(:ok)
      end

      it '存在しないユーザーの記事一覧ページを閲覧しようとした時' do
        expect {
          get user_posts_path(user_id: 99)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'ユーザーがログインしていない場合' do
      it '別ユーザーの記事一覧を見ることができる' do
        get user_posts_path(user_id: other_user.id)
        expect(response).to have_http_status(:ok)
      end

      it '存在しないユーザーの記事一覧ページを閲覧しようとした時' do
        expect {
          get user_posts_path(user_id: 99)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'GET #new' do
    context 'ログインユーザーの場合' do
      it '記事を作成するページを見ることができる' do
        get new_post_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'ユーザーがログインしていない場合' do
      it '記事を作成するページを見ることができない', :skip_before_action do
        get new_post_path
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'POST #create' do
    context 'ログインユーザーの場合' do
      context 'パラメーターが妥当な場合' do
        it 'リクエストが成功すること' do
          post posts_path(post: post_params)
          expect(response).to have_http_status(:found)
        end

        it 'createが成功すること' do
          expect do
            post posts_path(post: post_params)
          end.to change(Post, :count).by 1
        end

        it 'マイページにリダイレクトすること' do
          post posts_path(post: post_params)
          expect(response).to redirect_to :mypage_index
        end
      end
    end
  end

  describe 'GET #show' do
    context 'ログインユーザーの場合' do
      it 'リクエストが成功すること' do
        get user_post_path(user_id: new_post.user.id, id: new_post.id)
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'ユーザーがログインしていない場合' do
      it 'リクエストが成功すること', :skip_before_action do
        get user_post_path(user_id: new_post.user.id, id: new_post.id)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #edit' do
    context 'ログインユーザーの場合' do
      it '記事を編集するページを見ることができる' do
        get edit_post_path(new_post.id)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'ユーザーがログインしていない場合' do
      it '記事を編集するページを見ることができない', :skip_before_action do
        get edit_post_path(new_post.id)
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'PUT #update' do
    before do
      post_params[:title] = 'sample'
    end

    context 'ログインユーザーの場合' do
      it 'リクエストが成功すること' do
        put post_path(id: new_post.id, post: post_params)
        expect(response).to have_http_status(:found)
      end
    end

    context 'ユーザーがログインしていない場合' do
      it 'ログインページに遷移すること', :skip_before_action do
        put post_path(id: new_post.id, post: post_params)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログインユーザーの場合' do
      it 'リクエストが成功すること' do
        delete post_path(id: new_post.id)
        expect(response).to have_http_status(:found)
      end

      it '記事が削除されること' do
        expect do
          delete post_path(id: new_post.id)
        end.to change(Post, :count).by(-1)
      end
    end
  end
end
