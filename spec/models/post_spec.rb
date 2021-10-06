require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let(:test_post) { post }
    let!(:post) { build(:post, user_id: user.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        test_post.title = ''
        expect(test_post).to be_invalid
      end
    end

    context 'contentカラム' do
      it '空欄でないこと' do
        test_post.content = ''
        expect(test_post).to be_invalid
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
