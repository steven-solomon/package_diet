require 'spec_helper'

module Rendering
  describe GraphVizUI do
    let(:output_file) { 'spec/rendering/tmp/output.png' }

    after do
      File.delete(output_file) if File.exists?(output_file)
    end

    it 'raises an error when there is no graph' do
      expect { GraphVizUI.new('').render(nil) }.to raise_error(/Graph cannot be empty/)
      expect { GraphVizUI.new('').render([]) }.to raise_error(/Graph cannot be empty/)
    end

    it 'outputs file' do
      expect(File.exists?(output_file)).to eq(false)

      parsing_node_new = Parsing::Node.new('Some')

      renderer = GraphVizUI.new(output_file)
      renderer.render([parsing_node_new])

      expect(File.exists?(output_file)).to eq(true)
    end
  end
end
