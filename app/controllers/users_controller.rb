class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :spotify, :create, :login]
  def new
    if current_user
      redirect_to welcome_path
    else
      @user = User.new
      @user.songs.build
      @user.songs.build
      @user.songs.build
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
  end
  def create
    @user = User.create(user_params)
    if @user.save 
      UserAdapter.top_tracks(@user)
      session[:user_id] = @user.id
      redirect_to welcome_path
    else
      render :new 
    end
  end

  def login
    return redirect_to root_path, notice: "Cannot find username #{params[:user][:display_name]}" unless @user = User.find_by(display_name: params[:user][:display_name])
    if @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to welcome_path
    else
      flash[:notice] = "Password is incorrect" 
      redirect_to root_path
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
