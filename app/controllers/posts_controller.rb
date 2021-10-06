class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  helper_method :post_contributor?, :comment_contributor?

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to :mypage_index, success: '記事を作成しました。'
    else
      render action: :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to :mypage_index, success: '記事を更新しました。'
    else
      render action: :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to :mypage_index, success: '記事を削除しました。'
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def post_contributor?
    user_signed_in? && current_user.id == @post.user.id
  end

  def comment_contributor?(comment)
    user_signed_in? && current_user.id == comment.user.id || user_signed_in? && current_user.id == comment.post.user.id
  end
end
