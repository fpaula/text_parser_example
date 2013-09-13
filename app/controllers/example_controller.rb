class ExampleController < ApplicationController
  def index
    @gem_info = gem_info
    @user_ip = [
      request.env["HTTP_X_FORWARDED_FOR"],
      request.env['HTTP_X_REAL_IP'],
      request.env['REMOTE_ADDR'],
      request.remote_ip,
      request.remote_addr
    ]
  end
end
