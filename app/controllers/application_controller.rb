# frozen_string_literal: true

class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: 'prog', password: 'Fresh-Site'
end
