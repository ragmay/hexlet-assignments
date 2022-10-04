# frozen_string_literal: true

# BEGIN
def build_query_string(parameters)
  result = []
  parameters.sort.to_h.each do |k, v|
    result << "#{k}=#{v}"
  end
  result.join('&')
end
# END
