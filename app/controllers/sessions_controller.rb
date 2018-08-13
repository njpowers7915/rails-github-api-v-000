class SessionsController < ApplicationController

  skip_before_action :authenticate_user

  def create
    #session[:token] = params["access_token"]
    resp = Faraday.get("https://api.github.com/user?access_token=#{params["access_token"]}") do |req|
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_SECRET']
      req.params['code'] =
      req.params['access_token'] = params["access_token"]
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = params[:code]
    end

    body = JSON.parse(resp.body)
    session[:token] = body[:access_token]
    redirect_to root_path
  end
end
