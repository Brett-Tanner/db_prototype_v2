# frozen_string_literal: true

# Represents an event at a single school, with one or many time slots
# Must have a school
class Event < ApplicationRecord
  belongs_to :school
  delegate :area, to: :school
  belongs_to :member_prices, class_name: 'PriceList',
                             optional: true
  belongs_to :non_member_prices, class_name: 'PriceList',
                                 optional: true

  has_many :time_slots, dependent: :destroy
  accepts_nested_attributes_for :time_slots, allow_destroy: true,
                                             reject_if: :all_blank
  has_many :options, as: :optionable,
                     dependent: :destroy
  has_many :slot_options, through: :time_slots,
                          source: :options
  has_many :option_registrations, through: :time_slots
  has_many :registrations, through: :time_slots
  has_many :children, through: :registrations
  has_many :invoices, dependent: :destroy

  has_one_attached :image

  validates :name, :description, :start_date, :end_date, presence: true

  validates :start_date, comparison: { greater_than_or_equal_to: Time.zone.today, less_than_or_equal_to: :end_date }
  validates :end_date, comparison: { greater_than_or_equal_to: Time.zone.today }
  validates_comparison_of :end_date, greater_than_or_equal_to: :start_date

  # Scopes for event time
  scope :past_events, -> { where('end_date < ?', Time.zone.today).order(start_date: :desc) }
  scope :current_events, -> { where('start_date <= ? and end_date >= ?', Time.zone.today, Time.zone.today) }
  scope :future_events, -> { where('start_date > ?', Time.zone.today).order(start_date: :asc) }

  # List children attending from other schools
  def diff_school_children
    children.where.not(school: school).distinct
  end

  # List all children at the event's school,
  # plus those attending from different schools
  def possible_children
    children.where.not(school: school).distinct + Child.where(school: school)
  end
end
