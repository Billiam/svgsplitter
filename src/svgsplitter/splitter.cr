require "xml"

module Svgsplitter
  class Splitter
    @output : ACON::Output::Interface

    def initialize(input_path : String, output, output_path : String | Nil = nil, prefix : String | Nil = "")
      @output = output
      @input_path = input_path
      @output_path = output_path
      @prefix = prefix
    end

    def run(dry_run : Bool = false)
      raise ACON::Exceptions::ValidationFailed.new("SVG (#{@input_path}) could not be read") unless File.readable? @input_path

      input_path = Path[@input_path]
      xml = File.read @input_path

      output_directory = if output_param = @output_path
        Path[output_param].expand(Dir.current)
      else
        input_path.parent.join(input_path.stem)
      end

      unless Dir.exists?(output_directory)
        Dir.mkdir(output_directory)
      end

      document = XML.parse(xml)

      main_element = document.children.find do |child|
        child.name == "svg" && child.element?
      end

      raise "SVG could not be parsed" if main_element.nil?

      result =  main_element.children.select(&.element?).each do |child|
        new_document = build_file(xml, child["id"])
        if new_document
          filename = "#{@prefix}#{child["id"]}.svg".gsub(/[\/\\]/, "_")
          output_path = output_directory.join(filename)
          @output.puts "Writing <info>#{child["id"]}</info> to <info>#{output_path}</info>"
          write_file(new_document, output_path) unless dry_run
        end
      end
    end

    def write_file(content, path)
      File.write(path, content)
    end

    # Ineffeciently build new document by deleting all svg children except those matching the ID parameter
    def build_file(xml, id)
      document = XML.parse(xml)

      main_element = document.children.find do |child|
        child.name == "svg" && child.element?
      end
      return nil unless main_element

      main_element.children.each do |child|
        if child["id"] != id
          child.unlink
        end
      end
      document.to_s
    end
  end
end

