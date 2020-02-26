class Car < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :reviews,dependent: :destroy
  has_one_attached :photo
  belongs_to :user
  KINDS = ['Petrol', 'Diesel', 'Electric', 'Hybrid']
  validates :model, presence: true
  validates :brand, presence: true
  validates :kind, presence: true, inclusion: {in: KINDS}
  validates :price, presence: true
  validates :description, presence: true

  def info
    "#{self.brand.capitalize} #{self.model}, #{self.kind.downcase}."
  end

  def owner
    self.user.username
  end

  include PgSearch
  pg_search_scope :search, against: [:brand, :model], using: {tsearch: {prefix: true, any_word: true}}
end
