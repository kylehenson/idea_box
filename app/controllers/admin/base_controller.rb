class Admin::BaseController < ApplicationController
  before_action :require_admin

  def require_admin
    render :error unless current_admin?
  end

end
