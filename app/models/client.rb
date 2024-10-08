class Client < ApplicationRecord
  include Locationable

  mount_uploader :avatar, ImageUploader

  has_one :account, as: :accountable, dependent: :destroy
  has_many :vehicles, dependent: :destroy
  has_many :service_requests, through: :vehicles, dependent: :destroy
  has_many :offers, through: :service_requests, dependent: :destroy
  has_many :ratings, dependent: :nullify

  delegate :email, to: :account, allow_nil: true

  validates :phone, uniqueness: { case_sensitive: false }, if: -> { phone.present? }
  validates :card_token, presence: true, uniqueness: true, allow_nil: true

  def avatar_url
    avatar.present? ? avatar.url : ""
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[address avatar created_at id id_value location name phone updated_at card_token]
  end
end
