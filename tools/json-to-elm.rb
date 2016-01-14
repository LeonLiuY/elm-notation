require 'json'

json = File.read('../lib/bravura_metadata.json')

def indent(content)
    content.lines.map{|line| '    ' + line}.join
end

#wrap keys start with number
def wrap(key)
    "x" + key
end

def toElm(meta)
    if meta.is_a? Hash
        "{\n" + indent(meta.map {|key, value| "#{wrap(key)} = #{toElm(value)}" }.join(",\n")) + "\n}"
    elsif meta.is_a? Array
        "[\n" + indent(meta.map {|value| toElm(value) }.join(",\n")) + "\n]"
    else
        meta.inspect
    end
end
File.write('./Meta.elm', toElm(JSON.parse(json)))
