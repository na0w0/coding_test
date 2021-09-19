class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @user_id = params[:user_id]
    @posts = Post.where(user_id: @user_id)
  end

  def new 
    @post = current_user.posts.build
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash.notice = '記事を作成しました。'
      redirect_to :mypage_index
    else
      render action: 'new'
    end
  end

  def show
    @post = Post::find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def edit
    @post = Post::find(params[:id])
  end

  def update
    @post = Post::find(params[:id])
    if @post.update(post_params)
      flash.notice = '記事を更新しました。'
      redirect_to :mypage_index
    else
      render action: :edit
    end
  end

  def destroy
    @post = Post::find(params[:id])
    @post.destroy!
    flash.notice = '記事を削除しました。'
    redirect_to :mypage_index
  end

  private
  def post_params
    params.require(:post).permit(:user_id, :title, :content)
  end
end
