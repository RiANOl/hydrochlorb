module Hydrochlorb
  def build(*args, &block)
    Hydrochlorb::Builder.new(*args, &block)
  end
  module_function :build
end

require 'hydrochlorb/builder'
require 'hydrochlorb/serializer'
require 'hydrochlorb/version'
