class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(user_id: @user.id)
  end

  def new 
    @post = current_user.posts.build
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to :mypage_index, success: '記事を作成しました。'
    else
      render action: 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to :mypage_index, success: '記事を更新しました。'
    else
      render action: :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    redirect_to :mypage_index, success: '記事を削除しました。'
  end

  private
  def post_params
    params.require(:post).permit(:user_id, :title, :content)
  end
end
