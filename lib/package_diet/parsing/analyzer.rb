
module Parsing
  class Analyzer
    def initialize(ui)
      @ui = ui
    end

    def run(directory)
      if directory.nil?
        raise 'Directory must be provided'
      end

      directory_reader = DirectoryReader.new(directory)
      ruby_files = directory_reader.find_ruby_files

      if ruby_files.empty?
        raise 'Directory has no ruby files'
      end

      nodes = directory_reader.parse_files(ruby_files) do |package_name|
        Node.new(package_name.name)
      end

      ui.render(nodes)
    end

    private

    attr_accessor :ui
  end
end
