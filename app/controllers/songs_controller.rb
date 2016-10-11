class SongsController < ApplicationController
  def index
    @user = User.find(params[:user_id])    
    @songs = @user.songs
  end

  def new
    @song = Song.new(user_id: params[:user_id])  
  end

  def create
    @song = Song.create(song_params)
    redirect_to user_songs_path(current_user)
  end

  private

  def song_params
    params.require(:song).permit(:user_id, :name)
  end
end
