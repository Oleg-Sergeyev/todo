# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @users = policy_scope(User) # .page(params[:page]).per(15)
  end

  def show
    authorize @user
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
  end

  def destroy
    authorize @user
  end

  def set_user
    @user = User.find(params[:id])
  end
end
