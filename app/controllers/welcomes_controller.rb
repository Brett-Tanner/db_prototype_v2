# frozen_string_literal: true

# Just for routing to the welcome splash page
class WelcomesController < ApplicationController
  layout 'welcome'

  def current_event; end
end
