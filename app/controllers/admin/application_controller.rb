# frozen_string_literal: true

# class Admin::ApplicationController
class Admin::ApplicationController < ApplicationController
  before_action :authenticate_user!
  layout 'layouts/admin/application'

end
