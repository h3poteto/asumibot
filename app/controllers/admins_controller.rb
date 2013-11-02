class AdminsController < ApplicationController
  layout "admin"
  def after_sign_in_path_for(resource)
    case resource
    when Admins
      admins_serifs_path
    end
  end
  def after_sing_out_path_for(resource)
    case resource
    when Admins
      new_admin_session_path
    end
  end
end
