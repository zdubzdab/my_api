class ShortUserSerializer < ActiveModel::Serializer

  attributes :id, :email

  # has_many :articles
end
