class SongController < ApplicationController
  def index
    session[:history] ||= []
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
    @word = Word.all.sample.entry.chomp
    tracks = RSpotify::Track.search(@word)
    while tracks.empty? # guarantee results
      nap
      get_song
    end
    @track = tracks.sample
    session[:history] << [@track.name, @track.album.name, @track.artists.each.map{|x| x.name}.to_sentence]
  end
end
