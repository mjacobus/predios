# frozen_string_literal: true

dirs = [
  File.expand_path('../../lib', __dir__),
  File.expand_path('../../lib/predios/domain', __dir__),
  File.expand_path('../../lib/predios/services', __dir__),
]

dirs.each do |dir|
  unless $LOAD_PATH.include?(dir)
    $LOAD_PATH.unshift(dir)
  end
end
