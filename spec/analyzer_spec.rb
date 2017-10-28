require 'spec_helper'

describe Analyzer do
  it 'raises an error when directory is nil' do
    ui = double(:ui)
    package_diet = Analyzer.new(ui)

    expect{ package_diet.run(nil) }.to raise_error(/Directory must be provided/)
  end

  it 'raises an error when there is no ruby files' do
    directory = 'spec/fixtures/empty_directory'
    ui = double(:ui)
    package_diet = Analyzer.new(ui)

    expect{ package_diet.run(directory) }.to raise_error(/Directory has no ruby files/)
  end

  it 'asks UI to render a root package' do
    directory = 'spec/fixtures/class_with_no_module'
    ui = double(:ui, render: nil)
    package_diet = Analyzer.new(ui)

    package_diet.run(directory)

    expect(ui).to have_received(:render) do |graph|
      matches_node(graph.first, 'Root')
    end
  end

  it 'asks UI to render a package' do
    directory = 'spec/fixtures/class_with_module'
    ui = double(:ui, render: nil)
    package_diet = Analyzer.new(ui)

    package_diet.run(directory)

    expect(ui).to have_received(:render) do |graph|
      matches_node(graph.first, 'ExampleModule')
    end
  end

  it 'asks UI to render multiple packages' do
    directory = 'spec/fixtures/multiple_modules'
    ui = double(:ui, render: nil)
    package_diet = Analyzer.new(ui)

    package_diet.run(directory)

    expect(ui).to have_received(:render) do |graph|
      matches_node(graph.first, 'Another')
      matches_node(graph.last, 'One')
    end
  end

  def matches_node(graph, name)
    expect(graph.name).to eq(name)
    expect(graph.dependencies).to be_empty
  end
end
