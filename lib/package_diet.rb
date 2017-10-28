require "package_diet/version"
require "package_diet/file_reader"
require "package_diet/analyzer"
require "package_diet/file_parser"

module PackageDiet
  def self.run(path)
    analyzer = Analyzer.new(CommandLineUI)
    analyzer.run(path)
  end

  class CommandLineUI
    def render(nodes)
      nodes.each { |node| puts node.name }
    end
  end
end
