# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoice do
  let(:event) { create(:event) }

  context 'when using membership' do
    it 'uses member pricelist if child is member' do
      child = build(:child, category: :internal)
      invoice = build(
        :invoice,
        event: event,
        slot_regs: build_list(:slot_reg, 5, child: child),
        child: child
      )
      invoice.calc_cost
      expect(invoice.total_cost).to eq(5)
    end

    it 'uses non-member pricelist (and first time adjustment) if child is not member' do
      child = build(:child, category: :external)
      invoice = build(
        :invoice,
        event: event,
        slot_regs: build_list(:slot_reg, 5, child: child),
        child: child
      )
      invoice.calc_cost
      expect(invoice.total_cost).to eq(1110)
    end

    it 'does not apply first time adjustment if invoice has no registrations' do
      child = build(:child, category: :external)
      invoice = build(
        :invoice,
        event: event,
        slot_regs: [],
        child: child
      )
      invoice.calc_cost
      expect(invoice.total_cost).to eq(0)
    end
  end

  context 'when num_regs does not match a course' do
    let(:child) { build(:child, category: :internal) }

    it 'calculates cost with one spot use' do
      invoice = build(
        :invoice,
        event: event,
        slot_regs: build_list(:slot_reg, 1, child: child),
        child: child
      )
      invoice.calc_cost
      expect(invoice.total_cost).to eq(1)
    end

    it 'calculates cost with two spot uses' do
      invoice = build(
        :invoice,
        event: event,
        slot_regs: build_list(:slot_reg, 2, child: child),
        child: child
      )
      invoice.calc_cost
      expect(invoice.total_cost).to eq(2)
    end

    it 'calculates cost with one spot use over a course' do
      rand_num_regs = [6, 51].sample
      invoice = build(
        :invoice,
        event: event,
        slot_regs: build_list(:slot_reg, rand_num_regs, child: child),
        child: child
      )
      invoice.calc_cost
      expect(invoice.total_cost).to eq(rand_num_regs)
    end

    it 'calculates cost with 2 spot uses over a course' do
      rand_num_regs = [7, 52].sample
      invoice = build(
        :invoice,
        event: event,
        slot_regs: build_list(:slot_reg, rand_num_regs, child: child),
        child: child
      )
      invoice.calc_cost
      expect(invoice.total_cost).to eq(rand_num_regs)
    end

    it 'calculates internal cost with special 3 course over a course' do
      rand_num_regs = [8, 53].sample
      invoice = build(
        :invoice,
        event: event,
        slot_regs: build_list(:slot_reg, rand_num_regs, child: child),
        child: child
      )
      invoice.calc_cost
      expect(invoice.total_cost).to eq(rand_num_regs)
    end

    it 'calculates internal cost with 4 spot uses over a course (affected by 3 course)' do
      rand_num_regs = [9, 54].sample
      invoice = build(
        :invoice,
        event: event,
        slot_regs: build_list(:slot_reg, rand_num_regs, child: child),
        child: child
      )
      invoice.calc_cost
      expect(invoice.total_cost).to eq(rand_num_regs)
    end

    it 'calculates external cost with special 3 course over a course' do
      child.update(category: :external)
      rand_num_regs = [8, 53].sample
      invoice = build(
        :invoice,
        event: event,
        slot_regs: build_list(:slot_reg, rand_num_regs, child: child),
        child: child
      )
      invoice.calc_cost
      expect(invoice.total_cost).to eq(1_100 + (rand_num_regs * 2))
    end

    it 'calculates external cost with 4 spot uses over a course (affected by 3 course)' do
      child.update(category: :external)
      rand_num_regs = [9, 54].sample
      invoice = build(
        :invoice,
        event: event,
        slot_regs: build_list(:slot_reg, rand_num_regs, child: child),
        child: child
      )
      invoice.calc_cost
      expect(invoice.total_cost).to eq(1_100 + (rand_num_regs * 2))
    end
  end

  context 'when calculating snack cost' do
    it 'applies 165yen snack cost for each slot where snack boolean is true' do
      snack_slot = create(:time_slot, snack: true)
      no_snack_slot = create(:time_slot, snack: false)
      invoice = build(
        :invoice,
        event: event,
        slot_regs: [build(:slot_reg, registerable: snack_slot),
                    build(:slot_reg, registerable: no_snack_slot)]
      )
      invoice.calc_cost
      expect(invoice.total_cost).to eq(2 + 165)
    end
  end

  context 'when calculating int/ext kindy/ele modifiers' do
    it 'applies internal modifier if kid is internal' do
      child = build(:child, category: :internal)
      slot = create(:time_slot, int_modifier: 10)
      invoice = build(
        :invoice,
        event: event,
        child: child,
        slot_regs: [build(:slot_reg, registerable: slot)]
      )
      invoice.calc_cost
      expect(invoice.total_cost).to eq(11)
    end

    it 'applies external modifier if kid is external' do
      child = build(:child, category: :external)
      slot = create(:time_slot, ext_modifier: 10)
      invoice = build(
        :invoice,
        event: event,
        child: child,
        slot_regs: [build(:slot_reg, registerable: slot)]
      )
      invoice.calc_cost
      # plus 1100 because 1st time external
      expect(invoice.total_cost).to eq(1112)
    end

    it 'applies kindy modifier if kid is kindy' do
      child = build(:child, kindy: true, category: :internal)
      slot = create(:time_slot, kindy_modifier: 10)
      invoice = build(
        :invoice,
        event: event,
        child: child,
        slot_regs: [build(:slot_reg, registerable: slot)]
      )
      invoice.calc_cost
      expect(invoice.total_cost).to eq(11)
    end

    it 'applies ele modifier if kid is elementary' do
      child = build(:child, kindy: false, category: :internal)
      slot = create(:time_slot, ele_modifier: 10)
      invoice = build(
        :invoice,
        event: event,
        child: child,
        slot_regs: [build(:slot_reg, registerable: slot)]
      )
      invoice.calc_cost
      expect(invoice.total_cost).to eq(11)
    end

    it 'applies both kindy/ele and int/ext modifiers if both apply' do
      child = build(:child, kindy: true, category: :external)
      slot = create(:time_slot, kindy_modifier: 10, ext_modifier: 10)
      invoice = build(
        :invoice,
        event: event,
        child: child,
        slot_regs: [build(:slot_reg, registerable: slot)]
      )
      invoice.calc_cost
      # plus 1100 because 1st time external, and 2 cos external PL
      expect(invoice.total_cost).to eq(1122)
    end

    it 'does not apply modifiers multiple times if modified and non-modified slots mixed' do
      child = build(:child, kindy: true, category: :external)
      modifier_slot = create(:time_slot, kindy_modifier: 10)
      non_modifier_slot = create(:time_slot)
      invoice = build(
        :invoice,
        event: event,
        child: child,
        slot_regs: [build(:slot_reg, registerable: modifier_slot),
                    build(:slot_reg, registerable: non_modifier_slot)]
      )
      invoice.calc_cost
      # plus 1100 because 1st time external
      expect(invoice.total_cost).to eq(1114)
    end
  end
end
