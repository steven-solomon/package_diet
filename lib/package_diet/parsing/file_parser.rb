require 'parser/current'

module Parsing
  class FileParser
    def self.parse(file_contents)
      find_module_name(file_contents)
    end

    def self.find_module_name(file_contents)
      find_modules(file_contents) || 'Root'
    end

    def self.find_modules(file_contents)
      root = Parser::CurrentRuby.parse(file_contents)

      if root&.type == :class
        one = root.children.first
        two = one.children.first
        three = two&.children&.last
        three && three.to_s
      elsif root&.type == :module
        one = root.children.first
        two = one.children.last
        two.to_s
      end
    end
  end
end
