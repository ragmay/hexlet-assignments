# frozen_string_literal: true

require "uri"
require "open-uri"
require "addressable"
require_relative "ipgeobase/version"
require "net/http"
require_relative "ipgeobase/ip_meta_data"

module Ipgeobase
  URL = "http://ip-api.com/xml"

  def self.lookup(ip)
    template = Addressable::Template.new("#{URL}{/ip}")
    uri = template.expand ip: ip
    response = Net::HTTP.get_response(uri)
    IpMetaData.parse(response.body)
  end
end
