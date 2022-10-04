# frozen_string_literal: true

require 'uri'
require 'forwardable'

# BEGIN
class Url
  extend Forwardable
  include Comparable

  attr :url

  def <=>(other)
    @url.to_s <=> other.url.to_s
  end

  def initialize(url)
    @url = URI.parse(url)
  end

  def_delegators :@url, :scheme, :host

  def query_params
    return {} unless @url.query

    @query_params ||= URI.decode_www_form(@url.query).to_h.transform_keys(&:to_sym)
  end

  def query_param(key, *value)
    query_params.fetch(key) { |_key| value[0] }
  end
end

# END
