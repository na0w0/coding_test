require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'ユーザーがログインしている場合' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }

    describe "GET posts#index" do
      describe 'ログインユーザーの場合' do
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

      describe 'ユーザーがログインしていない場合' do

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

    describe "GET post#new" do
      
    end
  end
end
