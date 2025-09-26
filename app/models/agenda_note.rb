class AgendaNote < ApplicationRecord
  belongs_to :agenda

  validates :note, presence: true

  def to_processable_format
    { id: id, done: done, is_urgent: is_urgent }
  end
end
