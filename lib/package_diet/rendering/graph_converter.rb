module Rendering
  class GraphConverter
    def self.convert(graph)
      raise 'No nodes were provided' if graph.nil?

      format_graph(graph)
    end

    private

    def self.format_graph(graph)
      "digraph G{\n" +
        "  node [shape=component]\n" +
        "#{format_nodes(graph)}}\n"
    end

    def self.format_nodes(graph)
      graph
        .map { |node| format_node(node) }
        .join("")
    end

    def self.format_node(node)
      "  #{node.name};\n"
    end
  end
end
