require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        expect(user).to be_invalid
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'postモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end

    context 'commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
  end
end
