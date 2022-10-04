# frozen_string_literal: true

require "test_helper"
require "bigdecimal"
require "bigdecimal/util"

class IpgeobaseTest < TestCase
  def setup
    @ip = "8.8.8.8"
    @stub = stub_request(:get, "#{Ipgeobase::URL}/#{@ip}")
            .with(headers: { "Accept" => "*/*", "User-Agent" => "Ruby" })
            .to_return(status: 200, body: load_fixture("response.xml"), headers: {})
  end

  def test_lookup_http_query
    Ipgeobase.lookup @ip

    assert_requested @stub
  end

  def test_lookup_response_object
    meta = Ipgeobase.lookup @ip

    assert { 39.03.to_d == meta.lat.to_d }
    assert { -77.5.to_d == meta.lon.to_d }
    assert { "United States" == meta.country }
    assert { "Ashburn" == meta.city }
  end
end
