require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:post) { build(:post, user_id: user.id) }

    subject { test_post.valid? }
    let(:test_post) { post }

    context 'titleカラム' do
      it '空欄でないこと' do
        test_post.title = ''
        is_expected.to eq false
      end
    end

    context 'contentカラム' do
      it '空欄でないこと' do
        test_post.content = ''
        is_expected.to eq false
      end
    end

    describe 'アソシエーションのテスト' do
      context 'userモデルとの関係' do
        it 'N:1となっている' do
          expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
        end
      end

      context 'commentモデルとの関係' do
        it '1:Nとなっている' do
          expect(Post.reflect_on_association(:comments).macro).to eq :has_many
        end
      end
    end
  end
end
