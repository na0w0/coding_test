class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to user_post_path(id: @post.id, user_id: @post.user.id), success: 'コメントを追加しました。'
    else
      redirect_to user_post_path(@post), danger: 'コメントの追加に失敗しました。'
    end
  end

  def edit
    if current_user_post
      @post = current_user_post
      @comment = @post.comments.find(params[:id])
    else
      @comment = current_user.comments.find(params[:id])
      @post = @comment.post
    end
  end

  def update
    if current_user_post
      @post = current_user_post
      @comment = @post.comments.find(params[:id])
    else
      @comment = current_user.comments.find(params[:id])
      @post = @comment.post
    end
    if @comment.update(comment_params)
      redirect_to user_post_path(id: @post.id, user_id: @post.user.id), success: 'コメントを更新しました。'
    else
      redirect_to user_post_path(id: @post.id, user_id: @post.user.id), danger: 'コメントの更新に失敗しました。'
    end
  end

  def destroy
    if current_user_post
      @post = current_user_post
      @comment = @post.comments.find(params[:id])
    else
      @comment = current_user.comments.find(params[:id])
      @post = @comment.post
    end
    @comment.destroy!
    redirect_to user_post_path(id: @post.id, user_id: @post.user.id), success: 'コメントを削除しました。'
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def current_user_post
    current_user.posts.find_by_id(params[:post_id])
  end
end
