# frozen_string_literal: true

class SchoolsController < ApplicationController
  before_action :set_school, only: %i[edit show update]
  after_action :verify_authorized, except: %i[index]

  def index
    @schools = School.real.order(id: :desc).includes(calendar_setsumeikais: %i[school])
    respond_to do |f|
      f.json { render json: School.all }
    end
  end

  def show; end

  def new
    @school = authorize School.new
    form_data
  end

  def edit
    form_data
  end

  def create
    @school = authorize School.new(permitted_attributes(School))

    if @school.save
      redirect_to school_path(@school), notice: "Created #{@school.name}!"
    else
      form_data
      render :new, status: :unprocessable_entity,
                   alert: "Couldn't create #{@school.name}"
    end
  end

  def update
    if @school.update(permitted_attributes(@school))
      redirect_to school_path(@school), notice: "Updated #{@school.name}!"
    else
      form_data
      render :edit, status: :unprocessable_entity,
                    alert: "Couldn't update #{@school.name}"
    end
  end

  private

  def form_data
    @managers = User.school_managers
    @areas = Area.all
    @images = ActiveStorage::Blob.where('key LIKE ?', '%schools%')
                                 .map { |blob| [blob.key, blob.id] }
  end

  def set_school
    @school = authorize School.find(params[:id])
  end
end
