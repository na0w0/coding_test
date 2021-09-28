class CommentsController < ApplicationController
    before_action :authenticate_user!
    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.new(comment_params)
        @comment.user_id = current_user.id
        if @comment.save
            redirect_back(fallback_location: root_path, success: 'コメントを追加しました。')
        else
            redirect_back(fallback_location: root_path, danger: 'コメントの追加に失敗しました。')
        end
    end

    def edit
        @post = Post.find(params[:post_id])
        @comment = Comment.find(params[:id])
    end

    def update
        @post = Post.find(params[:post_id])
        @comment = Comment.find(params[:id])
        if @comment.update(comment_params)
            redirect_to user_post_path(@post), success: 'コメントを更新しました。'
        else
            redirect_back(fallback_location: root_path, danger: 'コメントの更新に失敗しました。')
        end
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy!
        redirect_back(fallback_location: root_path, success: 'コメントを削除しました。')
    end

    private
    
    def comment_params
        params.require(:comment).permit(:content)
    end
end
