require 'spec_helper'

module Rendering
  describe GraphConverter do
    it 'converts nodes to dot syntax' do
      expect { GraphConverter.convert(nil) }.to raise_error(/No nodes were provided/)
    end

    it 'converts empty graph into empty digraph' do
      expect(GraphConverter.convert([])).to eq(<<~GRAPH)
        digraph G{
          node [shape=component]
        }
      GRAPH
    end

    it 'converts single node into digraph' do
      node = Parsing::Node.new('A')
      expect(GraphConverter.convert([node])).to eq(<<~GRAPH)
        digraph G{
          node [shape=component]
          A;
        }
      GRAPH
    end

    it 'converts single node with single dependency into digraph' do
      node = Parsing::Node.new('A', [Parsing::Node.new('B')])
      expect(GraphConverter.convert([node])).to eq(<<~GRAPH)
        digraph G{
          node [shape=component]
          A -> { B };
        }
      GRAPH
    end

    it 'converts single node with multiple dependencies into digraph' do
      dependencies = [
        Parsing::Node.new('B'),
        Parsing::Node.new('C'),
      ]

      node = Parsing::Node.new('A', dependencies)
      expect(GraphConverter.convert([node])).to eq(<<~GRAPH)
        digraph G{
          node [shape=component]
          A -> { B C };
        }
      GRAPH
    end

    it 'converts multiple nodes into digraph' do
      a = Parsing::Node.new('A')
      b = Parsing::Node.new('B')
      c = Parsing::Node.new('C')
      graph = [a, b, c]

      expect(GraphConverter.convert(graph)).to eq(<<~GRAPH)
        digraph G{
          node [shape=component]
          A;
          B;
          C;
        }
      GRAPH
    end
  end
end
