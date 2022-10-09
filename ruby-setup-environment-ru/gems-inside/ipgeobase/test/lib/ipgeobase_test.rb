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
    @ip_self = "127.0.0.1"
    @stub_self = stub_request(:get, "#{Ipgeobase::URL}/#{@ip_self}")
                 .to_return(status: 200, body: load_fixture("response_127.0.0.1.xml"), headers: {})
    @ip_404 = "404"
    @stub_404 = stub_request(:get, "#{Ipgeobase::URL}/#{@ip_404}")
                .to_return(status: 200, body: load_fixture("response_404.xml"), headers: {})
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

  def test_lookup_error_self_http_query
    Ipgeobase.lookup @ip_self

    assert_requested @stub_self
  end

  def test_lookup_response_error_self_object
    meta = Ipgeobase.lookup @ip_self

    assert { "fail" == meta.status }
    assert { "reserved range" == meta.message }
    assert { "127.0.0.1" == meta.query }
  end

  def test_lookup_error404_http_query
    Ipgeobase.lookup @ip_404

    assert_requested @stub_404
  end

  def test_lookup_response_error404_object
    meta = Ipgeobase.lookup @ip_404

    assert { "fail" == meta.status }
    assert { "invalid query" == meta.message }
    assert { "404" == meta.query }
  end
end
