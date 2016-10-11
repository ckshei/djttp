class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :spotify, :create, :login]

  def new
    if current_user
      redirect_to welcome_path
    end
  end

  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    user = UserAdapter.create(spotify_user)
    if user
      session[:user_id] = user.id
      redirect_to welcome_path
    else
      flash[:error] = 'You fucked up'
    end
  end

  def home
    current_user
    @event = Event.new
    @events = Event.all
    respond_to do |format|
      format.html {render :home}
      format.json {render json: @events}
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
  
  def user_params
    params.require(:user).permit(:uid, :display_name, :password, :password_confirmation, :email, :top_tracks, :top_artists, songs_attributes:[:name])
  end
end
