class Article < ActiveRecord::Base
  has_many :comments
  belongs_to :user

  validates :title, :text, :user_id, presence: true
end
