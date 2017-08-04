class ApplicationController < ActionController::Base
  include Jpmobile::ViewSelector
  protect_from_forgery
  before_action :page_info_for_js

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admins_serifs_path
    end
  end
  def after_sign_out_path_for(resource)
    root_path
  end

  def page_info_for_js
    gon.controller = params[:controller]
    gon.action = params[:action]
    if params[:action] == 'show' && params[:page]
      gon.page = params[:page]
    end
  end
end
