readme = File.readlines(File.dirname(File.expand_path(__FILE__)) + '/../README.md').map(&:chomp)
specs =
  readme
    .drop_while do |line|
      line != '# readme.spec.rb'
    end
    .take_while do |line|
      line != '```'
    end
    .join("\n")

instance_eval specs
