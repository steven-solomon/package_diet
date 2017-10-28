require "package_diet/file_reader"

class Analyzer
  def initialize(ui)
    @ui = ui
  end

  def run(directory)
    if directory.nil?
      raise 'Directory must be provided'
    end

    file_reader = FileReader.new(directory)
    ruby_files = file_reader.find_ruby_files

    if ruby_files.size.zero?
      raise 'Directory has no ruby files'
    end

    nodes = file_reader.parse_files(ruby_files) do |package_name|
      Node.new(package_name)
    end

    ui.render(nodes)
  end

  private

  attr_accessor :ui

  class Node
    attr_reader :name, :dependencies

    def initialize(name)
      @name = name
      @dependencies = []
    end
  end
end
