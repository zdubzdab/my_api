class Api::V1::CommentsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]
  load_and_authorize_resource
  respond_to :json

  def create
    article = Article.find(params[:article_id])
    comment = Comment.new(comment_params)
    comment.user = current_user
    comment.article = article

    if comment.save
      render json: comment, status: 201
    else
      render json: { errors: comment.errors }, status: 422
    end
  end

  def show
    comment = Comment.find(params[:id])

    respond_with comment
  end

  def update
    comment = Comment.find(params[:id])

    if comment.update(comment_params)
      render json: comment, status: 200
    else
      render json: { errors: comment.errors }, status: 422
    end
  end

  def destroy
   comment = Comment.find(params[:id])
    if comment.destroy
      render json: "You've successfully deleted comment with id: #{comment.id} and text: #{comment.text}"
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:text, :article_id, :user_id)
    end
end
