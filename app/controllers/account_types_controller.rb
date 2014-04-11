class AccountTypesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index, :search]
  before_action :set_account_type, only: [:show, :edit, :update, :destroy]
  after_action :log_update, only: [:create, :update, :destroy]

  # GET /account_types
  # GET /account_types.json
  def index
    @account_types = AccountType.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /account_types/1
  # GET /account_types/1.json
  def show
  end

  # GET /account_types/new
  def new
    #authorize! :create, @account_type
    @account_type = AccountType.new
  end

  # GET /account_types/1/edit
  def edit
  end

  # POST /account_types
  # POST /account_types.json
  def create
    @account_type = AccountType.new(account_type_params)
    authorize! :create, @account_type

    respond_to do |format|
      if @account_type.save
        format.html { redirect_to @account_type, notice: 'Account type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @account_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @account_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account_types/1
  # PATCH/PUT /account_types/1.json
  def update
    authorize! :update, @account_type
    respond_to do |format|
      if @account_type.update(account_type_params)
        format.html { redirect_to @account_type, notice: 'Account type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @account_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account_types/1
  # DELETE /account_types/1.json
  def destroy
    authorize! :destroy, @account_type
    @account_type.destroy
    respond_to do |format|
      format.html { redirect_to account_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_type
      @account_type = AccountType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_type_params
      params.require(:account_type).permit(:name, :description, :max_expiry)
  end
  def log_update
    log_msg = "id: #{@account_type.id}\nname: #{@account_type.name}\ndescription: #{@account_type.description}\nmax_expiry: #{@account_type.max_expiry}\n" 
    ActivityLog.create(:item_type => controller_name.classify, :item_id => @account_type.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
  end
end
