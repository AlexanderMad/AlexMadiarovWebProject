class Product < ApplicationRecord
  # belongs_to :cart
  # has_many :comments, dependent: :destroy

  validates :title, presence: true,
                    length: { minimum: 1 }

  validates :description,  presence: true,
                    length: { minimum: 1 }

  validates :price,  presence: true

end
