require 'package_diet/version'
require 'package_diet/parsing/directory_reader'
require 'package_diet/parsing/analyzer'
require 'package_diet/parsing/file_parser'

module PackageDiet
  class Runner
    def self.run(path)
      analyzer = Parsing::Analyzer.new(CommandLineUI.new)
      analyzer.run(path)
    end
  end
end

class CommandLineUI
  def render(nodes)
    nodes.each { |node| puts node.name }
  end
end
