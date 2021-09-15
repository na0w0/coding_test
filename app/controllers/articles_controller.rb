class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @user_id = params[:user_id]
    @articles = Article.where(user_id: @user_id)
  end

  def new 
    @article = current_user.articles.build
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash.notice = '記事を作成しました。'
      redirect_to :mypage_index
    else
      render action: 'new'
    end
  end

  def show
    @article = Article::find(params[:id])
  end

  def edit
    @article = Article::find(params[:id])
  end

  def update
    @article = Article::find(params[:id])
    if @article.update(article_params)
      flash.notice = '記事を更新しました。'
      redirect_to :mypage_index
    else
      render action: :edit
    end
  end

  def destroy
    @article = Article::find(params[:id])
    @article.destroy!
    flash.notice = '記事を削除しました。'
    redirect_to :mypage_index
  end

  private
  def article_params
    params.require(:article).permit(:user_id, :title, :text)
  end
end
