class PlaylistsongsController < ApplicationController
  def destroy
    @playlistsong = Playlistsong.find(params[:id])
    @playlistsong.destroy
    render :nothing => true
  end

  def songs
    playlist = Playlist.find(params[:playlist_id])
    playlist.update_playlist_rankings
    songs = []
    playlist.playlistsongs.order(:ranking).each do |playlistsong|
      song_hash = playlistsong.song.attributes
      song_hash[:has_been_played] = playlistsong.has_been_played.to_s
      song_hash[:playlist_id] = playlistsong.playlist_id
      song_hash[:playlistsong_id] = playlistsong.id
      songs << song_hash
    end
    @playlistsong_json = songs.to_json
    render json: songs.to_json
  end

  def update
    playlistsong = Playlistsong.find(params[:playlistsong_id])
    if params[:has_been_played] == 'true'
      p playlistsong.update(has_been_played: true)
    end

    render :nothing => true
  end

end
