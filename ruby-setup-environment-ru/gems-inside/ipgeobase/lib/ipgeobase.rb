# frozen_string_literal: true

require "uri"
require "open-uri"
require_relative "ipgeobase/version"
require "addressable"
require "net/http"
require_relative "ipgeobase/ip_meta_data"

module Ipgeobase
  URL = "http://ip-api.com/xml"

  def self.lookup(ip)
    url = URI("http://ip-api.com/xml/#{ip}")

    http = Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Get.new(url)

    response = http.request(request)
    HappyMapper.parse(response.read_body)
  end
end
