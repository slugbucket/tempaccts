class User < ActiveRecord::Base
  has_and_belongs_to_many :roles, :join_table => :users_roles 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # Instead of using :authentication_keys here, we could put it in the
  # Devise initializer under config.authentication_keys
  devise :ldap_authenticatable, :rememberable, :trackable, :authentication_keys => [:username]

  # Replace with a validation of my own
  validates :username, :presence => true

  def self.find_for_authentication(conditions)
    conditions = ["username = ?", conditions[authentication_keys.first]]
    raise StandardError, conditions.inspect
    super
  end
  def create  
    @user_session = UserSession.new(params[:user_session])  
    if @user_session.save  
      flash[:notice] = "Login successful!"  
      redirect_to user_path  
    else  
      respond_to do |wants|  
        wants.html { render :new }  
        wants.js # create.js.erb  
      end  
    end  
  end
  def destroy  
    reset_session  
    flash[:notice] = "Logout successful!"  
    redirect_to user_path   
  end
  def self.name_of_user(id)
    "#{User.where(:id => id).username}"
  end
  # Scope to select users not assigned to a role
  scope :without_role, -> {select(:id, :username).joins(" LEFT JOIN users_roles ON users.id = users_roles.user_id").where("user_id IS NULL AND role_id IS NULL")}
end
