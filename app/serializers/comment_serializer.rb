class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text
  has_one :user, serializer: ShortUserSerializer
  has_one :article, serializer: ShortArticleSerializer
end
