require 'rails_helper'

RSpec.describe "Tops", type: :request do
  describe "GET #index" do
    context 'ユーザーがログインしている場合' do
      let!(:user) { create(:user) }

      before do
        login_as user
      end

      it 'ステータスコード200が返ってくる' do
        get root_path
        expect(response).to have_http_status(200)
      end
    end

    context 'ユーザーがログインしていない場合' do
      it 'ステータスコード200が返ってくる' do
        get root_path
        expect(response).to have_http_status(200)
      end
    end
  end
end