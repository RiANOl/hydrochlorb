module Hydrochlorb
  def build(&block)
    Hydrochlorb::Builder.new(&block)
  end
  module_function :build
end

require 'hydrochlorb/builder'
require 'hydrochlorb/serializer'
require 'hydrochlorb/version'
