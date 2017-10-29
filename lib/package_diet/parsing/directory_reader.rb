require 'set'

module Parsing
  class DirectoryReader
    def initialize(directory)
      @path = File.expand_path(directory)
    end

    def find_ruby_files
      Dir["#{@path}/**/*"]
        .reject { |thing| File.directory?(thing) }
        .select { |file| file.end_with?('.rb') }
    end

    def parse_files(ruby_files)
      files_set = ruby_files
      packages = files_set.map do |file_name|
        file_contents = File.read(file_name)
        package_name = FileParser.parse(file_contents)
        yield package_name
      end

      remove_duplicates(packages)
    end

    def remove_duplicates(packages)
      packages
        .to_set
        .to_a
    end

  end
end
