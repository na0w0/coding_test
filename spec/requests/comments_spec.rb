require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:new_post) { create(:post, user_id: user.id) }
  let!(:new_comment) { create(:comment, post_id: new_post.id, user_id: user.id)}
  let!(:comment_params) { attributes_for(:comment, post_id: new_post.id, user_id: user.id) }
  describe "POST #create" do
    context 'ログインユーザーの場合' do
      before do
        login_as user
      end

      it 'リクエストが成功すること' do
        post post_comments_path(post_id: new_post.id, comment: comment_params)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "GET #edit" do
    context 'ログインユーザーの場合' do
      before do
        login_as user
      end

      it 'リクエストが成功すること' do
        get edit_post_comment_path(id: new_comment.id, post_id: new_post.id)
        expect(response).to have_http_status(200)
      end
    end

    describe 'ユーザーがログインしていない場合' do
      it 'リクエストが成功すること' do
        get edit_post_comment_path(id: new_comment.id, post_id: new_post.id)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "PUT #update" do
    context 'ログインユーザーの場合' do
      before do
        login_as user
      end

      it 'リクエストが成功すること' do
        put post_comment_path(post_id: new_comment.post.id, id: new_comment.id, comment: comment_params)
        expect(response).to have_http_status(302)
      end

      it '記事の詳細ページに遷移すること' do
        # put post_comment_path(post_id: new_comment.post.id, id: new_comment.id, comment: comment_params)
        comment_params[:content] = 'sample'
        put post_comment_path(id: new_comment.id, post_id: new_comment.post_id, comment: comment_params)
        expect(response).to redirect_to user_post_path(new_comment.post)
      end
    end

    describe 'ユーザーがログインしていない場合' do
      it 'リクエストが成功すること' do
        put post_comment_path(post_id: new_comment.post.id, id: new_comment.id, comment: comment_params)
        expect(response).to have_http_status(302)
      end
      it 'ログインページへ遷移されること' do
        put post_comment_path(post_id: new_comment.post.id, id: new_comment.id, comment: comment_params)
        expect(response).to redirect_to :new_user_session
      end
    end
  end

  describe "DELETE #destroy" do
    context 'ログインユーザーの場合' do
      before do
        login_as user
      end

      it 'リクエストが成功すること' do
        delete post_comment_path(id: new_comment.id, post_id: new_comment.post.id)
        expect(response).to have_http_status(302)
      end

      it '記事が削除されること' do
        expect do
          delete post_comment_path(id: new_comment.id, post_id: new_comment.post.id)
        end.to change(Comment, :count).by(-1)
      end
    end
  end
end
