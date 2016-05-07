def parse_from_argv(parser)
  if ARGV.size != 1
    $stderr.puts "usage: #{$PROGRAM_NAME} [filename]"
    exit 1
  end

  unless File.file?(ARGV[0])
    $stderr.puts 'error: file not found'
    exit 1
  end

  string = File.read(ARGV[0])
  parser.read(string, Position.new).data
end

def main(parser)
  require 'pp'
  pp parse_from_argv(parser)
end
