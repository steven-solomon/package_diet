module Rendering
  class GraphConverter
    def self.convert(graph)
      raise 'No nodes were provided' if graph.nil?

      format_graph(graph)
    end

    private

    def self.format_graph(graph)
      <<~GRAPH
        digraph G{
          node [shape=component]
        #{format_nodes(graph)}}
      GRAPH
    end

    def self.format_nodes(graph)
      graph
        .map { |node| format_node(node) }
        .join('')
    end

    def self.format_node(node)
      if node.dependencies.empty?
        "  #{node.name};\n"
      else
        "  #{node.name} -> { #{format_dependencies(node)} };\n"
      end
    end

    def self.format_dependencies(node)
      node
        .dependencies
        .map(&:name)
        .join(' ')
    end
  end
end
