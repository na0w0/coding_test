require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let!(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:new_post) { create(:post, user_id: user.id) }
  let!(:new_comment) { create(:comment, post_id: new_post.id, user_id: user.id) }
  let!(:other_comment) { create(:comment, post_id: new_post.id, user_id: other_user.id) }
  let(:comment_params) { attributes_for(:comment) }
  let(:other_comment_params) { attributes_for(:comment) }

  describe 'POST #create' do
    context 'ログインユーザーの場合' do
      before do
        login_as user
      end

      it 'リクエストが成功すること' do
        post post_comments_path(post_id: new_post.id, comment: comment_params)
        expect(response).to have_http_status(:found)
      end

      it '記事の詳細ページに遷移すること' do
        post post_comments_path(post_id: new_post.id, comment: comment_params)
        expect(response).to redirect_to user_post_path(id: new_comment.post.id, user_id: new_comment.post.user.id)
      end
    end

    context '異なるログインユーザーの場合' do
      before do
        login_as other_user
      end

      it 'リクエストが成功すること' do
        post post_comments_path(post_id: new_post.id, comment: comment_params)
        expect(response).to have_http_status(:found)
      end

      it '記事の詳細ページに遷移すること' do
        post post_comments_path(post_id: new_post.id, comment: comment_params)
        expect(response).to redirect_to user_post_path(id: new_comment.post.id, user_id: new_comment.post.user.id)
      end
    end
  end

  describe 'GET #edit' do
    context 'ログインユーザーの場合' do
      before do
        login_as user
      end

      it 'リクエストが成功すること' do
        get edit_post_comment_path(id: new_comment.id, post_id: new_post.id)
        expect(response).to have_http_status(:ok)
      end

      it '自分の記事の異なるユーザーのコメントが編集できること' do
        get edit_post_comment_path(id: other_comment.id, post_id: new_post.id)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'ユーザーがログインしていない場合' do
      it 'リクエストが成功すること' do
        get edit_post_comment_path(id: new_comment.id, post_id: new_post.id)
        expect(response).to have_http_status(:found)
      end
    end

    context '異なるログインユーザーの場合' do
      before do
        login_as other_user
      end

      it 'リクエストが失敗すること' do
        expect {
          get edit_post_comment_path(id: new_comment.id, post_id: new_post.id)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'PUT #update' do
    context 'ログインユーザーの場合' do
      before do
        login_as user
      end

      it 'リクエストが成功すること' do
        put post_comment_path(post_id: new_comment.post.id, id: new_comment.id, comment: comment_params)
        expect(response).to have_http_status(:found)
      end

      it '記事の詳細ページに遷移すること' do
        comment_params[:content] = 'sample'
        put post_comment_path(id: new_comment.id, post_id: new_comment.post_id, comment: comment_params)
        expect(response).to redirect_to user_post_path(id: new_comment.post.id, user_id: new_comment.user.id)
      end

      it '自分の記事の異なるユーザーのコメントを更新できること' do
        other_comment_params[:content] = 'sample'
        put post_comment_path(id: other_comment.id, post_id: other_comment.post_id, comment: other_comment_params)
        expect(response).to have_http_status(:found)
      end
    end

    context 'ユーザーがログインしていない場合' do
      it 'リクエストが成功すること' do
        put post_comment_path(post_id: new_comment.post.id, id: new_comment.id, comment: comment_params)
        expect(response).to have_http_status(:found)
      end

      it 'ログインページへ遷移されること' do
        put post_comment_path(post_id: new_comment.post.id, id: new_comment.id, comment: comment_params)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context '異なるログインユーザーの場合' do
      before do
        login_as other_user
      end

      it 'リクエストが失敗すること' do
        expect {
          get edit_post_comment_path(id: new_comment.id, post_id: new_post.id)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログインユーザーの場合' do
      before do
        login_as user
      end

      it 'リクエストが成功すること' do
        delete post_comment_path(id: new_comment.id, post_id: new_comment.post.id)
        expect(response).to have_http_status(:found)
      end

      it '記事が削除されること' do
        expect do
          delete post_comment_path(id: new_comment.id, post_id: new_comment.post.id)
        end.to change(Comment, :count).by(-1)
      end

      it '自分の記事の異なるユーザーのコメントが削除できること' do
        expect do
          delete post_comment_path(id: other_comment.id, post_id: other_comment.post.id)
        end.to change(Comment, :count).by(-1)
      end
    end

    context '異なるログインユーザーの場合' do
      before do
        login_as other_user
      end

      it 'リクエストが失敗すること' do
        expect {
          get edit_post_comment_path(id: new_comment.id, post_id: new_post.id)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
