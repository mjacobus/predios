# frozen_string_literal: true

require 'addressable/template'

class GoogleMapsHelper
  JS_URL = 'https://maps.googleapis.com/maps/api/js'
  STATIC_MAP_URL = 'https://maps.google.com/maps/api/staticmap'
  KEY = 'AIzaSyCMFbHjf-I2rApFaatnmukLyfb1VIB8Jhk'

  def initialize(static_api_key:)
    @static_api_key = static_api_key
  end

  def script_url(options = {})
  end

  def api_key
    @static_api_key
  end

  def js_source(params = {})
    authorized_url(JS_URL, params).to_s
  end

  def image_url(territory, query_params = {})
    map = territory.map
    center = location_to_param(map.center)

    params = {
      center: center,
      size: '640x640', # max for free usage
      zoom: query_params.fetch(:zoom, 14),
    }

    other_params = []

    other_params += static_markers(map)
    other_params += [borders(map)]

    url = url_for(STATIC_MAP_URL, params.merge(key: @static_api_key)).to_s
    "#{url}&#{other_params.join('&')}"
  end

  private

  def static_markers(map)
    map.markers.with_geolocation.map do |marker|
      marker_location = marker.geolocation
      geolocation = location_to_param(marker_location)
      color = marker_location[:visit] ? 'red' : 'white'
      "markers=color:#{color}|#{geolocation}"
    end
  end

  def location_to_param(location)
    [location[:lat], location[:lng]].join(',')
  end

  def authorized_url(url, params)
    url_for(url, { key: KEY }.merge(params))
  end

  def url_for(url, params)
    url = Addressable::Template.new("#{url}{?query*}")
    url.expand(query: params)
  end
end
