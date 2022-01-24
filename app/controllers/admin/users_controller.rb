class Admin::UsersController < Admin::ApplicationController
  before_action :set_admin_user, only: %i[ show edit update destroy ]
  # after_action :verify_authorized, except: :index
  # after_action :verify_policy_scoped, only: :index
  
  # GET /admin/users or /admin/users.json
  def index
    authorize [:admin, User]
    admin_users = policy_scope(User, policy_scope_class: Admin::UserPolicy::Scope)
    sql = '(SELECT code FROM roles WHERE id = users.role_id) as code, id, name, email, active, role_id, created_at'
    #Rails.logger.info "++++#{User.select(code: Role.where(id: :user_id).pluck(:code).first).all}+++"
    @admin_users = admin_users.select(sql).page(params[:page]).per(5)
  end

  # GET /admin/users/1 or /admin/users/1.json
  def show
    authorize [:admin, User]
  end

  # GET /admin/users/new
  def new
    @admin_user = User.new
    authorize [:admin, @admin_user]
  end

  # GET /admin/users/1/edit
  def edit
    authorize [:admin, User]
  end

  # POST /admin/users or /admin/users.json
  def create
    @admin_user = User.new(admin_user_params)
    authorize [:admin, @admin_user]
    respond_to do |format|
      if @admin_user.save
        format.html { redirect_to [:admin, @admin_user], notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: [:admin, @admin_user] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1 or /admin/users/1.json
  def update
    authorize [:admin, @admin_user]
    respond_to do |format|
      if @admin_user.update(admin_user_params)
        format.html { redirect_to [:admin, @admin_user], notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: [:admin, @admin_user] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1 or /admin/users/1.json
  def destroy
    if current_user.admin? && @admin_user.admin?
      @admin_user.errors.add(:name, message: 'Impossible to delete!')
      render :show
      return nil
    end
    @admin_user.destroy
    authorize [:admin, @admin_user]
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_user
    @admin_user = User.find(params[:id])
    authorize [:admin, @admin_user]
  end

  # Only allow a list of trusted parameters through.
  def admin_user_params
    params.require(:user).permit(:id, :role_id, :name, :email, :password_confirmation, :password, :current_passwor,
      :active)
  end
end
