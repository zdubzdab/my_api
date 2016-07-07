class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article

  validates :text, :user_id, :article_id, presence: true
end
