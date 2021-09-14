class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    if current_user
      @user_id = current_user.id
    else
      @user_id = params[:user_id]
    end

    @articles = Article.where(user_id: @user_id)
  end

  def new 
    @article = current_user.articles.build
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash.notice = '記事を作成しました。'
      redirect_to :articles
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

  def destroy
  end

  private
  def article_params
    params.require(:article).permit(:user_id, :title, :text)
  end
end
