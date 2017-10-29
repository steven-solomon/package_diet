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
        class_constant = root.children.first
        module_constant = class_constant.children.first
        module_symbol = module_constant&.children&.last
        module_symbol&.to_s
      elsif root&.type == :module
        module_constant = root.children.first
        module_symbol = module_constant.children.last
        module_symbol.to_s
      end
    end
  end
end
