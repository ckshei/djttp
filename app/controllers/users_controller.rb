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
      redirect_to root_path
    else
      flash[:error] = 'You fucked up'
    end
  end


  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
  
end
