class SongController < ApplicationController
  def index
    
  end

  def song
    song = RSpotify::Track.search()
  end

  def about
    
  end
end
