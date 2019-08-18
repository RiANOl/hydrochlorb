require 'json'

class Hydrochlorb::Builder
  def initialize(&block)
    @attributes = {}
    @current = @attributes
    @context = nil

    build(&block) if block_given?
  end

  def build(&block)
    return unless block_given?

    @context = eval('self', block.binding)

    instance_eval(&block)

    self
  end

  def method_missing(method, *args, &block)
    if @context and @context.respond_to?(method)
      @context.send(method, *args, &block)
    else
      add(method, *args, &block)
    end
  end

  def add(*args, &block)
    if block_given?
      obj = {}
      k = args.first.to_sym

      @current[k] = [] unless @current[k].is_a? Array
      @current[k] << obj

      c = obj
      args[1..-1].each do |k|
        obj = {}
        c[k.to_sym] = obj
        c = obj
      end

      previous = @current
      @current = obj
      instance_eval(&block)
      @current = previous
    elsif args.length > 1
      method = args.shift.to_sym
      @current[method] = args.length == 1 ? args.first : args
    else
      raise ArgumentError, "One key and at least one of values are required: #{args.join(',')}"
    end
  end

  def to_json
    @attributes.to_json
  end

  def to_hcl(**options)
    Hydrochlorb::Serializer.serialize(@attributes, **options)
  end
end
