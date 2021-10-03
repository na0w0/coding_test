class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = current_user_post
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to user_post_path(id: @post.id, user_id: @post.user.id), success: 'コメントを追加しました。'
    else
      redirect_to user_post_path(@post), danger: 'コメントの追加に失敗しました。'
    end
  end

  def edit
    @post = current_user_post
    @comment = @post.comments.find(params[:id])
  end

  def update
    @post = current_user_post
    @comment = @post.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to user_post_path(@post), success: 'コメントを更新しました。'
    else
      redirect_to user_post_path(@post), danger: 'コメントの更新に失敗しました。'
    end
  end

  def destroy
    @post = current_user_post
    @comment = @post.comments.find(params[:id])
    @comment.destroy!
    redirect_to user_post_path(@post), success: 'コメントを削除しました。'
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def current_user_post
    current_user.posts.find(params[:post_id])
  end
end
