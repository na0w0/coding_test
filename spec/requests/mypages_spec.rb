require 'rails_helper'

RSpec.describe 'Mypage', type: :request do
  describe 'GET #index' do
    context 'ユーザーがログインしている場合' do
      let!(:user) { create(:user) }

      before do
        login_as user
      end

      it 'ステータスコード200が返ってくること' do
        get mypage_index_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'ユーザーがログインしていない場合' do
      it 'ステータスコード302が返ってくること' do
        get mypage_index_path
        expect(response).to have_http_status(:found)
      end
    end
  end
end
