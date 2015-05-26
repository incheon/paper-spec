class FileReader
  def initialize(path)
    @path = path
  end

  def content
    File.read(@path, encoding: Encoding::UTF_8)
  end
end
