# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User' do
  let(:valid_user) { build(:user) }
  let(:user) { create(:user) }
  let(:school) { create(:school) }

  context 'when valid' do
    it 'saves the User' do
      saves = valid_user.save
      expect(saves).to be true
    end

    it 'role is customer by default' do
      role = user.role
      expect(role).to eq 'customer'
    end
  end

  context 'when role is specified' do
    it 'sets role as customer' do
      role = create(:customer_user).role
      expect(role).to eq 'customer'
    end

    it 'sets role as school manager' do
      role = create(:sm_user).role
      expect(role).to eq 'school_manager'
    end

    it 'sets role as area manager' do
      role = create(:am_user).role
      expect(role).to eq 'area_manager'
    end

    it 'sets role as admin' do
      role = create(:admin_user).role
      expect(role).to eq 'admin'
    end

    it 'can be confirmed with #customer?' do
      confirmable = create(:customer_user).customer?
      expect(confirmable).to be true
    end

    it 'can be confirmed with #school_manager?' do
      confirmable = create(:sm_user).school_manager?
      expect(confirmable).to be true
    end

    it 'can be confirmed with #area_manager?' do
      confirmable = create(:am_user).area_manager?
      expect(confirmable).to be true
    end

    it 'can be confirmed with #admin?' do
      confirmable = create(:admin_user).admin?
      expect(confirmable).to be true
    end
  end

  context 'when password is invalid' do
    it 'rejects passwords shorter than 10 characters' do
      short_pass = build(:user, password: 'short')
      valid = short_pass.save
      expect(valid).to be false
    end

    it 'rejects users with no password' do
      no_pass = build(:user, password: 'nil')
      valid = no_pass.save
      expect(valid).to be false
    end
  end

  context 'when email is invalid' do
    it 'rejects users with no email' do
      no_email = build(:user, email: 'nil')
      valid = no_email.save
      expect(valid).to be false
    end
  end

  context 'when regular user' do
    it 'knows its school' do
      user_attr = attributes_for(:customer_user)
      customer = school.users.create(user_attr)
      customer_school = customer.school
      expect(customer_school).to be school
    end

    it "doesn't need a managed school" do
      no_managing = build(:user, managed_school: nil)
      no_managing_valid = no_managing.save
      expect(no_managing_valid).to be true
    end

    it "doesn't need a managed area" do
      no_managing = build(:user, managed_area: nil)
      no_managing_valid = no_managing.save
      expect(no_managing_valid).to be true
    end

    # Uses eq not be because you're comparing hashes converted from AR objects
    it 'knows its area through school' do
      customer = school.users.create(attributes_for(:customer_user))
      school_area = school.area
      customer_area = customer.area
      expect(school_area).to eq(customer_area)
    end
  end

  context 'when area manager' do
    subject(:area_manager) { create(:am_user) }

    it 'knows its managed area' do
      managed_area = area_manager.create_managed_area(attributes_for(:area))
      user_area = area_manager.managed_area
      expect(user_area).to be managed_area
    end

    it 'managed area knows manager' do
      managed_area = area_manager.create_managed_area(attributes_for(:area))
      manager = managed_area.manager
      expect(manager).to be area_manager
    end

    it "doesn't need a school" do
      no_school = build(:am_user)
      valid = no_school.save!
      expect(valid).to be true
    end
  end

  context 'when school manager' do
    subject(:school_manager) { create(:sm_user) }

    it 'knows its managed school' do
      managed_school = school_manager.create_managed_school(attributes_for(:school))
      user_school = school_manager.managed_school
      expect(user_school).to be managed_school
    end

    it 'managed school knows manager' do
      managed_school = school_manager.create_managed_school(attributes_for(:school))
      manager = managed_school.manager
      expect(manager).to be school_manager
    end

    it "doesn't need a school" do
      no_school = build(:sm_user)
      valid = no_school.save!
      expect(valid).to be true
    end
  end
end
