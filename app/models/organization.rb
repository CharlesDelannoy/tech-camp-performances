class Organization < ApplicationRecord
  has_many :agendas, dependent: :destroy

  validates :name, presence: true
end
