class ForecastsController < ApplicationController

require 'open-uri'
require 'json'

  def location
  @location = params[:address]
  the_address = @location

  url_of_data_we_want = "http://maps.googleapis.com/maps/api/geocode/json?address="
  url = url_of_data_we_want + the_address
  raw_data = open(url).read
  parsed_data = JSON.parse(raw_data)
  results = parsed_data["results"]
  first = results[0]
  lat = first["geometry"]["location"]["lat"]
  lng = first["geometry"]["location"]["lng"]

  the_latitude = lat
  the_longitude = lng

  url_of_data_want = "https://api.forecast.io/forecast/298307ef253aa87e5417597760d871fc/"
  url_2 = url_of_data_want + the_latitude.to_s + "," + the_longitude.to_s
  raw_data_2 = open(url_2).read
  parsed_data_2 = JSON.parse(raw_data_2)
  @the_temperature = parsed_data_2["currently"]["temperature"]

  hourly = parsed_data_2["hourly"]
  data = hourly["data"]
  first = data[1]
  summary = first["summary"]
  @the_hour_outlook = summary

  daily = parsed_data_2["daily"]
  data = daily["data"]
  first = data[1]
  summary = first["summary"]
  @the_day_outlook = summary

  render 'weather'
  end

end
