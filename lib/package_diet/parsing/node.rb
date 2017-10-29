module Parsing
  class Node
    attr_reader :name, :dependencies

    def initialize(name, dependencies = [])
      @name = name
      @dependencies = dependencies
    end

    def ==(other)
      name == other.name
    end

    alias :eql? :==

    def hash
      name.hash
    end
  end
end
