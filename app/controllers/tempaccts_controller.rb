class TempacctsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index, :search]
  before_action :set_tempacct, only: [:show, :edit, :update, :destroy]
  before_action :set_initials, only: [:index, :search]
  after_action :log_update, only: [:create, :update, :destroy]
  #load_and_authorize_resource

  # GET /tempaccts
  # GET /tempaccts.json
  def index
      if(params[:search]) then
      search_condition = "%" + params[:search] + "%"
      session[:search] = params[:search]
    elsif(session[:search])
      search_condition = "%" + session[:search] + "%"
    else
      search_condition = "%"
      session[:search] = nil
    end

    session[:tempacct_letter] = nil
    session[:tempacct_letter] ||= params[:q]

    @tempaccts = Tempacct.by_letter(session[:tempacct_letter]).paginate :page => params[:page], :per_page => 25
    session[:tempaccts_page] = (params[:page]) ? tempaccts_url+"?page="+params[:page] : tempaccts_url
  end

  # GET /tempaccts/1
  # GET /tempaccts/1.json
  def show
    if !session[:tempacct_page] then session[:tempacct_page] = tempaccts_url end
      begin
      @tempacct = Tempacct.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attmpt to access invalid alias id #{params[:id]}"
      redirect_to tempacctes_url, :notice => "Invalid or non-existent temporary account record"
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @tempacct }
      end
    end
  end

  # GET /tempaccts/new
  def new
    @tempacct = Tempacct.new
    authorize! :new, @tempacct
    if !session[:tempacct_page] then session[:tempacct_page] = tempaccts_url end
  end

  # GET /tempaccts/1/edit
  def edit
    @tempacct = Tempacct.find(params[:id])
    authorize! :edit, @tempacct
    if !session[:tempacct_page] then session[:tempacct_page] = tempaccts_url end
  end

  # POST /tempaccts
  # POST /tempaccts.json
  def create
    @tempacct = Tempacct.new(tempacct_params)
    authorize! :create, @tempacct
    respond_to do |format|
      if @tempacct.save
        #format.html { redirect_to @tempacct, notice: 'Tempacct was successfully created.' }
        format.html { redirect_to session[:tempacct_page], notice: 'Temporary account was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tempacct }
      else
        format.html { render action: 'new' }
        format.json { render json: @tempacct.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tempaccts/1
  # PATCH/PUT /tempaccts/1.json
  def update
  begin
    authorize! :update, @tempacct
    respond_to do |format|
      if @tempacct.update(tempacct_params)
        format.html { redirect_to @tempacct, notice: 'Tempacct was successfully updated.' }
        #format.html { redirect_to session[:tempacct_page], notice: 'Temporary account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tempacct.errors, status: :unprocessable_entity }
      end
    end
    
    rescue ActiveRecord::StatementInvalid
      logger.error "Invalid database update statement."
      redirect_to session[:tempacct_page], :notice => "Error: Invalid database update statement."
    end
  end

  # DELETE /tempaccts/1
  # DELETE /tempaccts/1.json
  def destroy
    authorize! :destroy, @tempacct
    @tempacct.destroy
    respond_to do |format|
      #format.html { redirect_to tempaccts_url }
      format.html{redirect_to session[:tempacct_page]}
      format.json { head :no_content }
    end
  end

  # GET /tempaccts/search
  def search
    if(params[:search]) then
      search_condition = "%" + params[:search] + "%"
      session[:search] = params[:search]
    else
      search_condition = "%"
      session[:search] = nil
    end
    #@tempaccts = Tempacct.paginate :page => params[:page], :order => 'uid asc', :per_page => 25, :conditions => ['uid LIKE ? OR description LIKE ? OR name LIKE ? OR name LIKE ?', search_condition, search_condition, search_condition, search_condition]
    @tempaccts = Tempacct.order("uid asc").paginate :page => params[:page], :per_page => 25, :conditions => ['uid LIKE ? OR description LIKE ? OR firstname LIKE ? OR surname LIKE ? OR expiry_date LIKE ?', search_condition, search_condition, search_condition, search_condition, search_condition]

    respond_to do |format|
      format.html { render action: 'index' }
      format.xml  { head :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tempacct
      @tempacct = Tempacct.find(params[:id])
    end
    def set_initials
      @first_letters = Tempacct.select("DISTINCT LOWER(SUBSTR(tempaccts.surname, 1, 1)) AS surname").order("surname").collect{|fl| "#{fl.surname}"}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tempacct_params
      params.require(:tempacct).permit(:firstname, :surname, :uid, :passwd, :owner, :expiry_date, :account_type_id, :ftp_login, :in_ldap, :printing, :description)
  end
  def log_update
    @at = AccountType.account_type_name(@tempacct.account_type_id)
    log_msg = "id: #{@tempacct.id}\nfirstname#{@tempacct.firstname}\nsurname#{@tempacct.surname}\nowner: #{@tempacct.owner}\nexpiry_date: #{@tempacct.expiry_date}\naccount_type:#{@at}\nftp_login:  #{@tempacct.ftp_login}\nin_ldap: #{@tempacct.in_ldap}\n\nprinting: #{@tempacct.printing}\ndescription: #{@tempacct.description}" 
    ActivityLog.create(:item_type => controller_name.classify, :item_id => @tempacct.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
  end
end
