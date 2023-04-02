class Store < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :store_name, presence: true, length: { maximum: 50 }
  VALID_PHONE_NUMBER_REGEX = /\A0(\d{1}[-(]?\d{4}|\d{2}[-(]?\d{3}|\d{3}[-(]?\d{2}|\d{4}[-(]?\d{1})[-)]?\d{4}\z|\A0[5789]0-?\d{4}-?\d{4}\z/ # rubocop:disable all
  validates :phone_number, presence: true, format: { with: VALID_PHONE_NUMBER_REGEX }
  validates :price, length: { maximum: 10 }
  validates :image, content_type: [:png, :jpg, :jpeg, { message: 'is not a PDF' }],
                    size: { less_than: 10.megabytes, message: 'is too large' }
end
