require 'net/http'
require 'uri'

class SongController < ApplicationController
  def index

    session[:history] ||= []


  end

  def song
    @access_token = retrieve_access_token
    get_song
  end

  def about

  end




  private 

  def get_song
    @word = Word.all.sample
    entry = @word.entry.chomp

    uri = URI.parse("https://api.spotify.com/v1/search?q=#{entry}&type=track")
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer BQC1-RiV7op7pWHN7zpaw3Zp-TBB3ujh8a6hL46WZRpLJbSYTUFwBB8QVFkm9bVKv5VnaDuKfEXk95qykdJKPg"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
      http.request(request)
    end

    tracks = JSON.parse(response.body)["tracks"]["items"]

    while tracks.empty? # guarantee results
      @word.destroy
      get_song
    end


    # HERE ---- Refactor for new JSON data
    @track = tracks.sample
    session[:history] << [@track.name, @track.album.name, @track.artists.each.map{|x| x.name}.to_sentence, Time.now.httpdate]
    @word = entry
  end

  def retrieve_access_token
    uri = URI.parse("https://accounts.spotify.com/api/token")
    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "Basic MDNlOWNhNDdiYjYyNGVkNDg5MTBmNmRiNDZhMzRmMjc6YmE4MGY3MGI5NjU4NGZlZjliZDFiZjBiOGRhNWZiMGQ="
    request.set_form_data(
      "grant_type" => "client_credentials",
      )

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
      http.request(request)
    end

    JSON.parse(response.body)["access_token"]
  end
end
