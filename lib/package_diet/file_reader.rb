class FileReader
  def initialize(directory)
    @path = File.expand_path(directory)
  end

  def find_ruby_files
    Dir.new(@path).select { |file| file.end_with?('.rb')}
  end

  def parse_files(ruby_files)
    ruby_files.map do |file_name|
      file_contents = read_file(file_name)
      package_name = FileParser.parse(file_contents)
      yield package_name
    end
  end

  def read_file(file_path)
    File.read(@path + '/' + file_path)
  end
end
