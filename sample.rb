require "ripper"
require "pp"

# load tex file
io = File.open("./dir1/dir2/sample.tex")
sections = 0

while line = io.gets
  tokens = Ripper.tokenize line.chomp

  # if /^\\((sub)*)section\s*\{\s*(.+)\s*\}/ ~= line
  #   subs = $0.scan("sub").length
  # elsif /[\{\}]/ ~= line
  #   sections += line.count("{") - line.count("}")
  # end
end

io.close
