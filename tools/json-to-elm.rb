require 'json'
require 'erb'

fontMeta = JSON.parse(File.read('../ref/bravura_metadata.json'), object_class: OpenStruct)
renderer = ERB.new File.read('./font_meta.erb')

File.open('../src/Notation/FontMeta.elm', 'w') { |f|
  f.write renderer.result
}
