class Api::V1::ArticlesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]
  load_and_authorize_resource
  respond_to :json

  def create
    article = Article.new(article_params)
    article.user = current_user

    if article.save
      render json: article, status: 201
    else
      render json: { errors: article.errors }, status: 422
    end
  end

  def update
    article = Article.find(params[:id])

    if article.update(article_params)
      render json: article, status: 200
    else
      render json: { errors: article.errors }, status: 422
    end
  end

  def index
    articles = Article.all
    render json: articles
  end

  def show
    article = Article.find(params[:id])
    render json: "Title: #{article.title}, Text: #{article.text}, Author: #{article.user.email}"
  end

  def destroy
   article = Article.find(params[:id])
    if article.destroy
      render json: "You've successfully deleted article with title: #{article.title}"
    end
  end

  private

    def article_params
      params.require(:article).permit(:title, :text, :user_id)
    end
end
