# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'search' do
  let(:user) { create(:admin) }

  before do
    sign_in user
  end

  context 'when searching users' do
    let!(:target) { create(:user, name: 'Tommy boi') }
    let!(:extra) { create(:user) }

    it 'can search by name for partial match' do
      visit users_path
      within '#users_search' do
        fill_in 'search_name', with: 'Tom'
        click_button I18n.t('shared.search.search')
      end
      expect(page).to have_content(target.name)
      expect(page).not_to have_content(extra.name)
    end
  end

  context 'when searching children' do
    let!(:target) { create(:child, katakana_name: 'カタカナ') }
    let!(:extra) { create(:child) }

    it 'can search by katakana name for partial match' do
      visit children_path
      within '#children_search' do
        fill_in 'search_katakana_name', with: 'カタカナ'
        click_button I18n.t('shared.search.search')
      end
      expect(page).to have_content(target.katakana_name)
      expect(page).not_to have_content(extra.name)
    end
  end
end
