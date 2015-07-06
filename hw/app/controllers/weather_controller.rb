require 'uri'
require 'open-uri'
require 'rexml/document'

class WeatherController < ApplicationController
  def enter_city
    render "city"
  end

  def show_current_conditions
    @city = params[:city]
    unit='f'
    id = get_id(@city)
    url = "http://xml.weather.yahoo.com/" +
        "forecastrss/#{id}_#{unit.downcase}.xml"
    xml = open(url) { |f| f.read }
    doc = REXML::Document.new(xml)
    @temperature = doc.elements['/rss/channel/item/yweather:condition/@temp'].to_s.to_i
    @wind_direction = doc.elements['/rss/channel/yweather:wind/@direction'].to_s.to_i
    @wind_speed = doc.elements['/rss/channel/yweather:wind/@speed'].to_s.to_i
    @humidity = doc.elements['/rss/channel/yweather:atmosphere/@humidity'].to_s.to_i
    @visibility = doc.elements['/rss/channel/yweather:atmosphere/@visibility'].to_s.to_i
    @unit = unit.upcase
    @url = url
    render "current_conditions"
  end

  private
  def get_id(location)
    location = URI.escape(location)
    url = "http://xoap.weather.com/search/search?where=#{location}"
    xml = open(url) { |f| f.read }

    doc = REXML::Document.new(xml)
    locations = doc.elements.to_a("/search/loc")
    raise "Cannot find the location." if locations.size <= 0
    @location = locations[0].text.sub(/\s*\(\d+\)\s*$/, '')
    locations[0].attributes['id']
  end

end