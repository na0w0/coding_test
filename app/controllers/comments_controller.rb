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

    private
    
    def comment_params
        params.require(:comment).permit(:content)
    end
end
