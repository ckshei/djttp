class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :spotify]

  def new
    if current_user
      redirect_to root_path
    end
  end

  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    user = UserAdapter.create(spotify_user)
    if user
      session[:user_id] = user.id
      return redirect_to root_path unless session.include? :sync_url
      sync_url = session[:sync_url]
      session[:sync_url] = nil
      return redirect_to sync_url
    else
      flash[:error] = 'You fucked up'
    end
  end


  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
  
end
