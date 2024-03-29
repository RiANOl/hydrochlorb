require 'json'

class Hydrochlorb::Serializer
  class << self
    def serialize(obj, indent: 2)
      dump(obj, indent: indent)
    end

    private

    def dump(obj, key: nil, indent: 0, depth: 0)
      prefix = ' ' * indent * depth

      case obj
      when Array
        if !obj.empty? && obj.all? { |v| v.is_a? Hash }
          obj.map do |v|
            send(__method__, v, key: key, indent: indent, depth: depth)
          end.compact.join("\n")
        else
          "#{prefix}#{key} = [" + obj.map { |v| send(__method__, v) }.compact.join(', ') + ']'
        end
      when Hash
        compacted = key.to_s.empty? || (!obj.empty? && obj.values.all? { |v| v.is_a? Hash })

        str = obj.map do |k, v|
          k = k.to_s.strip
          k = k.to_json unless k =~ /^\w+$/ and (key.to_s.empty? or not compacted)

          send(__method__, v, key: (compacted ? "#{key} #{k}".strip : k), indent: indent, depth: (compacted ? depth : depth + 1))
        end.compact.join("\n")

        compacted ?  str : "#{prefix}#{key} {\n" + (str.empty? ? '' : "#{str}\n") + "#{prefix}}"
      when Numeric, TrueClass, FalseClass
        (key ? "#{prefix}#{key} = " : '') + obj.to_json
      else
        (key ? "#{prefix}#{key} = " : '') + obj.to_s.to_json unless obj.nil?
      end
    end
  end
end
