# frozen_string_literal: true

# Represents a single school
# Must have a school manager
class School < ApplicationRecord
  belongs_to :area

  has_many :managements, as: :manageable,
                         dependent: :destroy
  has_many :managers, through: :managements
  has_many :users, dependent: :restrict_with_exception
  delegate :customers, to: :users
  has_many :children, dependent: nil
  has_many :events, -> { order(start_date: :asc) }, dependent: :destroy,
                                                    inverse_of: :school
  has_many :time_slots, through: :events
  has_many :options, through: :time_slots
  has_many :option_registrations, through: :time_slots
  has_many :registrations, through: :time_slots

  # Validations
  validates :name, :address, :phone, presence: true
  validates :phone, format: { with: /\A[0-9 \-+x.)(]+\Z/, message: I18n.t('schools.validations.phone') }
  validate :managers, :school_manager?

  # Instance methods
  def next_event
    events.order(start_date: :asc).limit(1).first
  end

  private

  def school_manager?
    return false unless managers || managers.all(&:school_manager?)

    true
  end
end
