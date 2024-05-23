module Svgsplitter
  class Splitter
    def initialize(input_path : String, output_path : String | Nil = nil, prefix : String | Nil = "")
      @input = input_path
      @output = output_path
      @prefix = prefix
    end

    def run(dry_run : Bool = false)
      raise ACON::Exceptions::ValidationFailed.new("SVG (#{@input}) could not be read") unless File.readable? @input
    end
  end
end

