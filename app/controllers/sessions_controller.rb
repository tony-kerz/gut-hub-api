class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    logger.debug { "create" }
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    render :status => 200,
           :json => {:success => true,
                     :info => "Logged in",
                     :user => current_user
           }
  end

  def destroy
    logger.debug { "destroy" }
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    sign_out
    render :status => 200,
           :json => {:success => true,
                     :info => "Logged out",
           }
  end

  def failure
    logger.debug { "failure" }
    render :status => 401,
           :json => {:success => false,
                     :info => "Login Credentials Failed"
           }
  end

  def show_current_user
    logger.debug { "show-current-user" }
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    render :status => 200,
           :json => {:success => true,
                     :info => "Current User",
                     :user => current_user
           }
  end

  def dummy
    logger.debug { "dummy" }
    render :status => 200,
           :json => {:success => true,
                     :info => "dummy!"
           }
  end
end