class UserSerializer < ActiveModel::Serializer

  attributes :id, :email, :created_at, :auth_token

  has_many :articles, serializer: ShortArticleSerializer
  has_many :comments, serializer: ShortCommentSerializer
end
