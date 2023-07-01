class MembersOnlyArticlesController < ApplicationController
  before_action :authenticate_user, only: [:index, :show]

  def index
    if user_signed_in?
      articles = Article.where(is_member_only: true).includes(:user).order(created_at: :desc)
      render json: articles, each_serializer: ArticleListSerializer
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def show
    if user_signed_in?
      article = Article.find(params[:id])
      render json: article
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private

  def authenticate_user
    unless user_signed_in?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def user_signed_in?
    # Replace with your logic to check if the user is signed in
    # For example, you can use Devise's current_user helper
    current_user.present?
  end
end
