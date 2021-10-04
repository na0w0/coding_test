class MypageController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = current_user.posts.order(created_at: 'DESC').page(params[:page]).per(5)
  end
end
