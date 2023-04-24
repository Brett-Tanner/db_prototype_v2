# frozen_string_literal: true

# Handles flow of information for Time Slots
class TimeSlotsController < ApplicationController
  def index
    @events = policy_scope(TimeSlot).order(:start_date)
  end

  def show
    @slot = TimeSlot.find(params[:id])
  end

  def edit
    @slot = TimeSlot.find(params[:id])
  end

  def update
    @slot = TimeSlot.find(params[:id])

    if @slot.update(slot_params)
      redirect_to time_slot_path(@slot), notice: t('update_success')
    else
      render :edit, status: :unprocessable_entity, notice: t('update_fail')
    end
  end

  private

  def slot_params
    params.require(:time_slot).permit(:name, :image, :start_time, :end_time, :description, :category, :closed,
                                      :morning, :event_id)
  end
end
