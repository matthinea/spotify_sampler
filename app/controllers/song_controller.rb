require 'time'

class SongController < ApplicationController
  def index
    session[:history] ||= []

    uri = URI.parse("https://accounts.spotify.com/api/token")
    params = {'grant_type' => "client_credentials"}
    headers = {
      'Authorization' => "Authorization: Basic #{ENV["client_id"]}:#{ENV["client_secret"]}",
      'token_type' => "bearer",
    }

    http = Net::HTTP.new(uri.host, uri.port)
    response = http.post(uri.path, params.to_json, headers)
    output = response.body
    puts output
  end

  def song
    get_song
  end

  def about

  end




  private 

  def nap 
    sleep 1.5
  end

  def get_song
    @word = Word.all.sample
    entry = @word.entry.chomp
    tracks = RSpotify::Track.search(entry)
    while tracks.empty? # guarantee results
      @word.destroy
      nap
      get_song
    end
    @track = tracks.sample
    session[:history] << [@track.name, @track.album.name, @track.artists.each.map{|x| x.name}.to_sentence, Time.now.httpdate]
    @word = entry
  end
end
