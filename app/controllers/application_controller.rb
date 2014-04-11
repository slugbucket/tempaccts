class ApplicationController < ActionController::Base
   rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render file: "public/login_error.html", status: 401
  end
  rescue_from Net::LDAP::LdapError do |exception|
    redirect_to root_url,  :alert =>'Directory connection error.'
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Rescue from the unsightly routing not found error when trying to delete
  # a phones record. (Doesn't actually work).
  # https://gist.github.com/Sujimichi/2349565
  # http://stackoverflow.com/questions/4525715/custom-error-page-ruby-on-rails
  # Suggests the following, but it doesn't work.
  # match "*path", :to => 'errors/500', :via => [:get, :post]
  # http://techoctave.com/c7/posts/36-rails-3-0-rescue-from-routing-error-solution
  # It doesn't work either.
  # For Rails 4, according to http://api.rubyonrails.org/classes/ActiveSupport/Rescuable/ClassMethods.html
  # It doesn't work with routing errors.
  rescue_from ActiveRecord::RecordInvalid, with: :show_errors
  rescue_from ActiveRecord::StatementInvalid, with: :db_invalid_stmt
  rescue_from ActiveRecord::RecordNotFound, with: :no_record_errors
  rescue_from ActionView::Template::Error, with: :template_error
  # The next two are known not to work with Rails 3/4
  #rescue_from ActionController::RoutingError, with: :routing_error
  rescue_from AbstractController::ActionNotFound, with: :render_not_found

  rescue_from 'MyAppError::Base' do |exception|
    render xml: exception, status: 500
  end
  # Show a more presentable access denied page
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => "You are not authorized to access this page."
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
  end
  # Configure allowed parameters for Devise controller
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
  def routing_error(exception)
      render text: "Routing error: #{exception.message}\n:Subject: #{exception.inspect}.", status: 500
      #render file: "public/500.html", status: 500
  end
    def show_errors(exception)
      render text: "General error: #{exception.message}\n:Subject: #{exception.inspect}.", status: 500
      #render file: "public/500.html", status: 500
  end
  def no_record_errors(exception)
    session.delete :search
    session.delete :tempacct_letter
    session.delete :tempacct_page
    redirect_to root_url, :alert => "Missing record error #{exception.message}."
  end
  def db_invalid_stmt(exception)
    session.delete :search
    session.delete :tempacct_letter
    session.delete :tempacct_page
    redirect_to root_url, :alert => "Invalid database statement #{exception.message}."
  end
  def template_error(exception)
    session.delete :search
    session.delete :tempacct_letter
    session.delete :tempacct_page
    redirect_to root_url, :alert => "Template error: #{exception.message}."
  end
  def render_not_found(exception = nil)
    render_exception(404, 'Not Found', exception)
  end
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :password, :remember_me) }
  end
end
