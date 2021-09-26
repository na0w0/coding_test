require 'rails_helper'

RSpec.describe 'Mypage', type: :request do
  describe "GET /mypage" do
    describe 'ユーザーがログインしている場合' do
      let!(:user) { create(:user) }

      before do
        login_as user
      end

      it 'ステータスコード200が返ってくること' do
        get mypage_index_path
        expect(response).to have_http_status(200)
      end
    end

    describe 'ユーザーがログインしていない場合' do
      it 'ステータスコード302が返ってくること' do
        get mypage_index_path
        expect(response).to have_http_status(302)
      end
    end
  end
end
