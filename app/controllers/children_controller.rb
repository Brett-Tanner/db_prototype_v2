# frozen_string_literal: true

# Control flow of data for Children
class ChildrenController < ApplicationController
  def index
    # Find a child to add
    return find_child if params[:commit] == 'Find Child'

    # List children attending an event or time slot
    if params[:source]
      find_source

      return render "#{@source.class.name.downcase}_index"
    end

    # By default, see the list of children current user is responsible for
    @children = role_index
  end

  def show
    @child = Child.find(params[:id])
    role_show
  end

  def new
    @child = if params[:parent]
               Child.new(parent_id: params[:parent])
             else
               Child.new
             end
  end

  def edit
    @child = Child.find(params[:id])
  end

  def create
    @child = Child.new(child_params)

    if @child.save
      flash_success
      redirect_to child_path(@child)
    else
      flash_failure
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @child = Child.find(params[:id])

    if @child.update(child_params)
      flash_success
      redirect_to child_path(@child)
    else
      flash_failure
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def child_params
    params.require(:child).permit(:id, :ja_first_name, :ja_family_name,
                                  :katakana_name, :en_name, :category,
                                  :birthday, :level, :allergies, :ssid,
                                  :ele_school_name, :post_photos, :needs_hat,
                                  :received_hat, :parent_id, :school_id,
                                  registrations_attributes: %i[
                                    child_id registerable_type
                                    registerable_id
                                  ])
  end

  def customer_show
    @slots = @next_event.time_slots.limit(5)
  end

  def find_child
    @child = search_result
    render 'users/_add_child', locals: { parent: User.find(params[:parent_id]) }
  end

  def flash_failure
    flash.now[:alert] = t('.failure')
  end

  def flash_success
    flash.now[:notice] = t('.success')
  end

  def role_show
    @parent = @child.parent
    @school = @child.school
    @next_event = @school.next_event
    return staff_show if current_user.staff?

    customer_show
  end

  def staff_show
    @slots = @next_event.time_slots
  end

  def search_result
    Child.find_by(ssid: params[:ssid], birthday: params[:bday])
  end

  def find_children
    case params[:source]
    when 'Event'
      @children = @source.children.distinct.includes(
        :invoices, :regular_schedule, :registrations, :time_slots, :options
      )
    when 'TimeSlot'
      @children = @source.children.distinct.includes(options: :registrations)
    else
      render status: :unprocessable_entity
    end
  end

  def find_source
    @source = params[:source].constantize.find(params[:id])
    @children = find_children

    @source
  end

  def role_index
    return Child.all if current_user.admin?
    return current_user.area_children if current_user.area_manager?
    return current_user.school_children if current_user.school_manager?
  end
end
