class CommentsController < ApplicationController
    def create
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id
        if @comment.save
            flash.notice = 'コメントを追加しました。'
            redirect_to :mypage_index
        else
            flash.notice = 'コメントの追加に失敗しました。'
        end
    end

    private
    
    def comment_params
        params.require(:comment).permit(:content)
    end
end
