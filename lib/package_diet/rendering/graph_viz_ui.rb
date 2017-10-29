require 'tempfile'

module Rendering
  class GraphVizUI
    def initialize(path)
      @path = path
    end

    def render(graph)
      if graph.nil? || graph.empty?
        raise 'Graph cannot be empty'
      end

      file = write_graph_to_file(graph)

      system("dot -Tpng #{file.path} -o #{@path}")

      file.unlink
    end

    private

    def write_graph_to_file(graph)
      file = Tempfile.new('graph')
      file.write(GraphConverter.convert(graph))
      file.close
      file
    end
  end
end
