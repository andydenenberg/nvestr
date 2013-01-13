class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  before_filter :prepare_for_mobile

  private

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      req_type = request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?

#    puts 'request format: ' + request.format
#    print 'request.user_agent =~ /Mobile|webOS/ -> '
#    puts request.user_agent =~ /Mobile|webOS/
#    puts 'request.user_agent: ' + request.user_agent
#    puts mobile_device?
#    print 'session[:mobile_param] '
#    puts session[:mobile_param] if session[:mobile_param]
#    puts params[:mobile]

  end
      
end
