class SessionsController < Devise::SessionsController
  before_filter :log_logout, :only => :destroy  #add this at the top with the other filters
  after_filter :log_failed_login, :only => [:new, :create]

  def create
    super
    username = params[:user]["username"]
    Rails.logger.debug "Login request from #{username}.\n"
    log_msg = "Successful login for #{username}"
    ActivityLog.create(:item_type => controller_name.classify, :item_id => 0, :act_action => action_name, :updated_by => params[:user]["username"], :activity => log_msg, :act_tstamp => Time.now)
  end

  private
  def log_failed_login
    Rails.logger.debug "\n***\nFailed login with username : #{request.parameters["username"]}\n***\n" if failed_login?
  end 

  def failed_login?
    (options = env["warden.options"]) && options[:action] == "unauthenticated"
  end

  def log_logout
    log_msg = "Logging out : #{current_user.username}"
    ActivityLog.create(:item_type => controller_name.classify, :item_id => 0, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
  end
end
