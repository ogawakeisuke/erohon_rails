require 'open-uri'

class ErohonsController < ApplicationController
  def search
  end

  def result
    input_word = params[:search_word]
    escape_word =  URI.encode(input_word)
    api_key = "aIQhjeojN20dOxId6UfCsEtq6x4gd7d8o4Na8KVf7jZ6SiNYg3"
    url= "http://api.tumblr.com/v2/tagged?tag=#{escape_word}&api_key=#{api_key}"
  
    uri = URI.parse(url).read
    res = JSON.parse(uri)

    responses = res["response"]
    @input_word = input_word
    @img_urls = []
    responses.each do |response|
      next unless response["photos"]
      @img_urls << response["photos"].first["original_size"]["url"]
    end

    render :pdf  => input_word, :layout => 'pdf', :encoding => 'UTF-8'
  end

end
