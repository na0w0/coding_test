class MypageController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = current_user.posts.order(created_at: :desc).page(params[:page])
  end
end
