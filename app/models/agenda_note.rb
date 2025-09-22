class AgendaNote < ApplicationRecord
  belongs_to :agenda

  validates :note, presence: true
end
