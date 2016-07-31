class SongController < ApplicationController
  def index
    
  end

  def song
    get_song
  end

  def about
    
  end

  private 

  def get_song
    @word = Word.all.sample.entry.chomp
    tracks = RSpotify::Track.search(@word)
    get_song while tracks.empty? # guarantee results
    @track = tracks.sample
  end
end
