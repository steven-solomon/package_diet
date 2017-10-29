require 'package_diet/version'
require 'package_diet/parsing/directory_reader'
require 'package_diet/parsing/analyzer'
require 'package_diet/parsing/file_parser'
require 'package_diet/parsing/node'
require 'package_diet/rendering/graph_viz_ui'
require 'package_diet/rendering/graph_converter'

module PackageDiet
  class Runner
    def self.run(path)
      analyzer = Parsing::Analyzer.new(
        Rendering::GraphVizUI.new('./package-structure.png')
      )
      analyzer.run(path)
    end
  end
end
