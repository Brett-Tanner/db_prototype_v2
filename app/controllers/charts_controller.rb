# frozen_string_literal: true

# Provides data for the charts pages
class ChartsController < ApplicationController
  TEST_SCHOOLS = [1, 2].freeze
  CATEGORIES = %w[activities bookings children coupons edits options].freeze

  def index
    authorize(:chart)
    @nav = nav_data('index')
    @data = send("#{@nav[:category]}_data")
  end

  def show
    @nav = nav_data('show')
    @data = send("#{@nav[:category]}_data")
  end

  private

  def activities_data
    school = @nav[:school]

    if school.id.zero?
      activities_all_data
    else
      activities_school_data(school)
    end
  end

  def activities_all_data
    event_ids = Event.where(name: @nav[:event], school_id: School.real.ids).ids
    slots = TimeSlot.where(event_id: event_ids)

    {
      activities: slots.morning.or(slots.special)
                       .group(:name).sum(:registrations_count),
      afternoons: slots.afternoon.where.not(category: :special)
                       .group(:name).sum(:registrations_count),
      slots: slots
    }
  end

  def activities_school_data(school)
    slots = school.events.find_by(name: @nav[:event]).time_slots

    {
      activities: slots.morning.or(slots.special)
                       .group(:name).sum(:registrations_count),
      afternoons: slots.afternoon.where.not(category: :special)
                       .group(:name).sum(:registrations_count),
      slots: slots
    }
  end

  def bookings_data
    school = @nav[:school]

    if school.id.zero?
      bookings_all_data
    else
      bookings_school_data(school)
    end
  end

  def bookings_all_data
    event_ids = Event.where(name: @nav[:event], school_id: School.real.ids).ids
    invoices = Invoice.where(event_id: event_ids)

    {
      invoices: invoices,
      regs: Registration.where(
        registerable_type: 'TimeSlot',
        invoice_id: invoices.ids
      )
    }
  end

  def bookings_school_data(school)
    event = school.events.find_by(name: @nav[:event])

    {
      invoices: event.invoices,
      regs: event.registrations
    }
  end

  def children_data
    school = @nav[:school]

    if school.id.zero?
      {
        children: children_all,
        hat_kids: children_hat_all
      }
    else
      event = school.events.find_by(name: @nav[:event])

      {
        children: event.children.includes(:real_invoices),
        hat_kids: school.hat_kids
      }
    end
  end

  def children_all
    event_ids = Event.where(name: @nav[:event]).ids

    Child.joins(:real_invoices)
         .where(real_invoices: { event_id: event_ids })
         .includes(:real_invoices)
  end

  def children_hat_all
    Child.joins(:adjustments)
         .where(
           adjustments: {
             reason: '帽子代(野外アクティビティに参加される方でKids UP帽子をお持ちでない方のみ)'
           }
         )
  end

  def coupons_data
    school = @nav[:school]

    if school.id.zero?
      {}
    else
      event = school.events.find_by(name: @nav[:event])
      invoice_ids = Invoice.where(event_id: event.id).ids

      Coupon.where(couponable_id: invoice_ids)
    end
  end

  def edits_data
    school = @nav[:school]

    if school.id.zero?
      {}
    else
      parent_ids = school.parents.ids

      {
        customer_edits: PaperTrail::Version
          .where(item_type: 'Invoice', event: 'update', whodunnit: parent_ids)
          .group_by_day(:created_at).count,
        staff_edits: PaperTrail::Version
          .where(item_type: 'Invoice', event: 'update', whodunnit: User.staff.ids)
          .group_by_day(:created_at).count
      }
    end
  end

  def nav_data(action)
    {
      category: nav_category,
      categories: CATEGORIES,
      event: params[:event] || Event.last.name,
      events: Event.all.pluck(:name).uniq,
      schools: policy_scope(School),
      school: nav_school(action)
    }
  end

  def nav_category
    CATEGORIES.find { |c| c == params[:category] } || CATEGORIES[0]
  end

  def nav_school(action)
    if action == 'show'
      authorize(School.find(params[:id]))
    else
      School.new(id: 0, name: 'All Schools')
    end
  end

  def options_data
    school = @nav[:school]

    if school.id.zero?
      {}
    else
      event = school.events.find_by(name: @nav[:event])
      slot_ids = event.time_slots.ids

      {
        all_opts: options_all(slot_ids.push(event.id)),
        arrive_opts: options_arrive(slot_ids.push(event.id)),
        depart_opts: options_depart(slot_ids.push(event.id))
      }
    end
  end

  def options_all(optionable_ids)
    Option.where(optionable_id: optionable_ids)
          .joins(:registrations)
          .group('options.name')
  end

  def options_arrive(optionable_ids)
    Option.where(
      optionable_id: optionable_ids,
      category: %i[arrival k_arrival]
    )
          .joins(:registrations)
          .group('options.name')
          .count('options.name')
          .except('なし')
  end

  def options_depart(optionable_ids)
    Option.where(
      optionable_id: optionable_ids,
      category: %i[departure k_departure]
    )
          .joins(:registrations)
          .group('options.name')
          .count('options.name')
          .except('なし')
  end
end
