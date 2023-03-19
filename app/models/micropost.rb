class Micropost < ApplicationRecord
  belongs_to :user
  belongs_to :store
  validates :title, :content, presence: true
  validates :user_id, uniqueness: { scope: :store_id }
end
