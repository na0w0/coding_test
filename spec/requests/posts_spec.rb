require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:new_post) { create(:post, user_id: user.id) }
  let!(:post_params) { attributes_for(:post, user_id: user.id) }

  describe 'GET #index' do
    context 'ログインユーザーの場合' do
      before do
        login_as user
      end

      it '自分の記事の一覧ページを閲覧しようとするとmypageにリダイレクトする' do
        get user_posts_path(user_id: user.id)
        expect(response).to redirect_to(mypage_index_path)
      end

      it '別ユーザーの記事一覧を見ることができる' do
        get user_posts_path(user_id: other_user.id)
        expect(response).to have_http_status(200)
      end

      context '存在しないユーザーの記事一覧ページを閲覧しようとした時' do
        subject { -> { get user_posts_path(user_id: 99) } }
        it { is_expected.to raise_error ActiveRecord::RecordNotFound }
      end
    end

    context 'ユーザーがログインしていない場合' do
      it '別ユーザーの記事一覧を見ることができる' do
        get user_posts_path(user_id: other_user.id)
        expect(response).to have_http_status(200)
      end

      context '存在しないユーザーの記事一覧ページを閲覧しようとした時' do
        subject { -> { get user_posts_path(user_id: 99) } }
        it { is_expected.to raise_error ActiveRecord::RecordNotFound }
      end
    end
  end

  describe 'GET #new' do
    context 'ログインユーザーの場合' do
      before do
        login_as user
      end
      it '記事を作成するページを見ることができる' do
        get new_post_path
        expect(response).to have_http_status(200)
      end
    end

    context 'ユーザーがログインしていない場合' do
      it '記事を作成するページを見ることができない' do
        get new_post_path
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'POST #create' do
    context 'ログインユーザーの場合' do
      before do
        login_as user
      end

      context 'パラメーターが妥当な場合' do
        it 'リクエストが成功すること' do
          post posts_path(post: post_params)
          expect(response).to have_http_status(302)
        end

        it 'createが成功すること' do
          expect do
            post posts_path(post: post_params)
          end.to change(Post, :count).by 1
        end

        it 'リクエストが成功すること' do
          post posts_path(post: post_params)
          expect(response).to redirect_to :mypage_index
        end
      end
    end
  end

  describe 'GET #show' do
    context 'ログインユーザーの場合' do
      before do
        login_as user
      end

      it 'リクエストが成功すること' do
        get user_post_path(user_id: new_post.user.id, id: new_post.id)
        expect(response).to have_http_status(200)
      end
    end

    describe 'ユーザーがログインしていない場合' do
      it 'リクエストが成功すること' do
        get user_post_path(user_id: new_post.user.id, id: new_post.id)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET #edit' do
    context 'ログインユーザーの場合' do
      before do
        login_as user
      end
      it '記事を編集するページを見ることができる' do
        get edit_post_path(new_post.id)
        expect(response).to have_http_status(200)
      end
    end

    context 'ユーザーがログインしていない場合' do
      it '記事を編集するページを見ることができない' do
        get edit_post_path(new_post.id)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'PUT #update' do
    context 'ログインユーザーの場合' do
      before do
        login_as user
      end

      it 'リクエストが成功すること' do
        post_params[:title] = 'sample'
        put post_path(id: new_post.id, post: post_params)
        expect(response).to have_http_status(302)
      end
    end

    describe 'ユーザーがログインしていない場合' do
      context 'titleカラム' do
        it 'リクエストが成功すること' do
          post_params[:title] = 'sample'
          put post_path(id: new_post.id, post: post_params)
          expect(response).to redirect_to new_user_session_path
        end

        it 'editテンプレートで表示されること' do
          post_params[:title] = 'sample'
          put post_path(id: new_post.id, post: post_params)
          expect(response).to redirect_to new_user_session_path
        end  
      end  
    end
  end

  describe 'DELETE #destroy' do
    describe 'ログインユーザーの場合' do
      before do
        login_as user
      end

      it 'リクエストが成功すること' do
        delete post_path(id: new_post.id)
        expect(response).to have_http_status(302)
      end

      it '記事が削除されること' do
        expect do
          delete post_path(id: new_post.id)
        end.to change(Post, :count).by(-1)
      end
    end
  end
end
