class CarMake < ApplicationRecord
  scope :categorized, lambda {
    select( 'car_makes.*, car_categories.name AS category_name' )
      .joins( :car_category )
      .group_by( &:category_name )
  }

  has_many :car_models, dependent: :destroy
  belongs_to :car_category

  validates :car_category_id, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :car_category_id }
end