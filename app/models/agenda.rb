class Agenda < ApplicationRecord
  belongs_to :organization
  has_many :agenda_notes, dependent: :destroy
  has_many :appointments, dependent: :destroy

  validates :name, presence: true
end
