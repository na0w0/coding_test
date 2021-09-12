class ArticlesController < ApplicationController
  before_action :authenticate_user!, expect: [ :show ]

  def index
    @articles = Article.where(user_id: current_user.id)
  end

  def new 
    @article = current_user.articles.build
  end

  def create
    @article = Article.new(article_params)
    logger.debug('--- article ---')
    logger.debug(@article.user_id)
    logger.debug(@article.title)
    logger.debug(@article.text)
    logger.debug('---------------')
    if @article.save
      flash.notice = '記事を作成しました。'
      # redirect_to :
    else
      render action: 'new'
    end
  end

  def show
    redirect_to [ :edit, current_user ]
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
