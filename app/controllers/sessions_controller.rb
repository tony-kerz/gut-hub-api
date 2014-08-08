# ref: http://jes.al/2013/08/authentication-with-rails-devise-and-angularjs/
# ref: https://github.com/jesalg/RADD
class Api::SessionsController < Devise::SessionsController
  respond_to :json
  before_filter :ensure_current_id!, only: [:show, :destroy]

  CURRENT = 'current'

  def create
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    render status: :created, json: current_user, serializer: SessionSerializer
  end

  def destroy
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    sign_out
    render status: :ok, json: {status: 'logged out'}
  end

  def show
    warden.authenticate(:scope => resource_name, :recall => "#{controller_path}#failure")
    render status: :ok, json: current_user, serializer: SessionSerializer
  end

  def failure
    render status: :unauthorized, json: {status: 'login failed'}
  end

  def ensure_current_id!
    raise "only id value of [#{CURRENT}] supported" unless params[:id] == CURRENT
  end
end
