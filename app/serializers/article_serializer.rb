class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :text
  has_one :user
end
