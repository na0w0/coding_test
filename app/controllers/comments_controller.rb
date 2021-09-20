class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.new(comment_params)
        @comment.user_id = current_user.id
        if @comment.save
            flash.notice = 'コメントを追加しました。'
            redirect_back(fallback_location: root_path)
        else
            flash.notice = 'コメントの追加に失敗しました。'
            redirect_back(fallback_location: root_path)
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
            flash.notice = 'コメントを更新しました。'
            redirect_to post_path(@post)
        else
            flash.notice = 'コメントの更新に失敗しました。'
            redirect_back(fallback_location: root_path)
        end
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy!
        flash.notice = 'コメントを削除しました。'
        redirect_back(fallback_location: root_path)
    end

    private
    
    def comment_params
        params.require(:comment).permit(:content)
    end
end
