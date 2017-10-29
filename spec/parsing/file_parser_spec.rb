require 'spec_helper'

module Parsing
  describe FileParser do
    it 'returns root when file is empty' do
      empty_file_contents = ''

      result = FileParser.parse(empty_file_contents)

      expect(result).to eq('Root')
    end

    it 'returns root when there is only a class' do
      file_contents = <<-FILE
      class ClassName
      end
      FILE

      result = FileParser.parse(file_contents)

      expect(result).to eq('Root')
    end

    it 'returns root when there class references another module' do
      file_contents = <<-FILE
      class ClassName
        def initialize
          Module::Symbol
        end
      end
      FILE

      result = FileParser.parse(file_contents)

      expect(result).to eq('Root')
    end

    it 'returns module name when there is a module' do
      file_contents = <<-FILE
      module ExampleModule
      end
      FILE

      result = FileParser.parse(file_contents)

      expect(result).to eq('ExampleModule')
    end

    it 'returns module name when it is part of class' do
      file_contents = <<-FILE
      class AnotherModule::ClassName
      end
      FILE

      result = FileParser.parse(file_contents)

      expect(result).to eq('AnotherModule')
    end
  end
end
