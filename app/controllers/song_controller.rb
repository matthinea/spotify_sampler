require 'net/http'
require 'uri'

class SongController < ApplicationController
  def index

    session[:history] ||= []


  end

  def song
    @access_token = retrieve_access_token
    get_song(@access_token)
  end

  def about

  end




  private 

  def get_song(access_token)

    tracks = []

    loop do

      word = Word.all.sample
      @word = word.entry.chomp

      response = search_using_keyword(access_token, @word)

      tracks = parse_response_for_track_list(response)
      if tracks.empty?
        word.destroy!
      else
        break
      end
    end 

    # while tracks is empty
    # keep getting a new word and hitting the API with that word
    # until tracks is not empty

    @track = tracks.sample
    add_track_info_to_session_history(@track)
    session[:history].shift if session[:history].size > 10
  end

  def retrieve_access_token
    uri = URI.parse("https://accounts.spotify.com/api/token")
    request = Net::HTTP::Post.new(uri)

    request["Authorization"] = "Basic #{ENV["encoded_client_id_and_secret"]}"
    request.set_form_data(
      "grant_type" => "client_credentials",
      )
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
      http.request(request)
    end

    access_token = JSON.parse(response.body)["access_token"]
  end

  def search_using_keyword(access_token, search_word)
    uri = URI.parse("https://api.spotify.com/v1/search?q=#{search_word}&limit=40&type=track")
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{access_token}"
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
      http.request(request)
    end
  end

  def parse_response_for_track_list(response)
    JSON.parse(response.body)["tracks"]["items"]
  end

  def add_track_info_to_session_history(track)
    session[:history] << [track["name"], track["album"]["name"], track["artists"].each.map{|x| x["name"]}.to_sentence, Time.now.httpdate]
  end
end
