module Parsing
  class FileParser
    def self.parse(file_contents)
      find_module_name(file_contents)
    end

    def self.find_module_name(file_contents)
      if match = file_contents.match(/module\s+(\S+)/)
        match[1]
      elsif match = file_contents.match(/class\s+(\S+)::\S+/)
        match[1]
      else
        'Root'
      end
    end
  end
end
