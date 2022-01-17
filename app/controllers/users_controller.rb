# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @users = policy_scope(User) # .page(params[:page]).per(15)
    @error = 'ooo'
  end

  def show
    authorize @user
  end

  def edit
   
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    
    @user = User.find(params[:id])
    authorize @user
    # if @user.update_attributes(user_params)
    #   # Handle a successful update.
    # else
    #   render 'edit'
    # end
    #return if current_user.default?
    
    Rails.logger.info "*************************#{user_params}********************************"
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    authorize @user
    if current_user.admin? && @user.admin?
      @error = 'Impossible to delete!'
      render :show
      return nil
    end
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :commit, :name, :email, :password_confirmation, :password, :current_passwor, :active)
  end
end
