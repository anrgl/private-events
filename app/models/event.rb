class Event < ApplicationRecord
  scope :past, -> { where('date < ?', DateTime.now ) }
  scope :future, -> { where('date > ?', DateTime.now ) }

  has_many :rsvps, foreign_key: :attended_event_id
  has_many :attendees, through: :rsvps

  belongs_to :creator, class_name: 'User'
end
