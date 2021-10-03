require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:post) { build(:post, user_id: user.id) }
    let!(:comment) { build(:comment, post_id: post.id, user_id: user.id) }

    subject { test_comment.valid? }
    let(:test_comment) { comment }

    context 'contentカラム' do
      it '空欄でないこと' do
        test_comment.content = ''
        is_expected.to eq false
      end
    end

    describe 'アソシエーションのテスト' do
      context 'userモデルとの関係' do
        it '1:1となっている' do
          expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
        end
      end

      context 'postモデルとの関係' do
        it '1:1となっている' do
          expect(Comment.reflect_on_association(:post).macro).to eq :belongs_to
        end
      end
    end
  end
end
