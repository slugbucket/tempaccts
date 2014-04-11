class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  # GET /roles
  # GET /roles.json
  def index
    #@roles = role.all
    @roles = Role.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
  end

  # GET /roles/new
  def new
    @role = Role.new
    authorize! :edit, @role
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new(role_params)
    authorize! :create, @role
    respond_to do |format|
      if @role.save
        format.html { redirect_to @role, notice: 'role was successfully created.' }
        format.json { render action: 'show', status: :created, location: @role }
      else
        format.html { render action: 'new' }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    authorize! :update, @role
    
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to @role, notice: 'role was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    authorize! :destroy, @role
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_role
    @role = Role.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def role_params
    params.require(:role).permit(:name, :resource_id, :resource_type, user_tokens: [] )
  end
  def log_update
    log_msg = "id: #{@role.id}\nname: #{@role.name}\nresource_id: #{@role.resource_id}\nresource_type: #{@role.resource_type}\nusers: " 
    ActivityLog.create(:item_type => controller_name.classify, :item_id => @role.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
    #Rails.logger.debug "DEBUG: #{current_user.username} Updated data: ext #{ext} in subdept #{sdp} for #{@role.user_name}"
  end
end

