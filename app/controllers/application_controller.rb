class ApplicationController < ActionController::Base
  include SessionsHelper
  helper :all
  protect_from_forgery

  before_filter :set_user_language
  before_filter :prepare_for_mobile

  #----------
  private
  def set_user_language
    I18n.locale = current_user.language if signed_in? 
  end

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~/Mobile|webOS/i
    end
  end
  helper_method :mobile_device?
  
  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.firmat = :mobile if mobile_device?
  end
end
