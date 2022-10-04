# frozen_string_literal: true

# BEGIN
def compare_versions(version1, version2)
  version1 = version1.split('.').map(&:to_i)
  version2 = version2.split('.').map(&:to_i)
  if version1[0] == version2[0]
    version1[1] <=> version2[1]
  else
    version1[0] <=> version2[0]
  end
end
# END
