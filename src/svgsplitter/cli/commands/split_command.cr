require "../../splitter"

@[ACONA::AsCommand("split", description: "Split SVG layers into separate SVGs")]
class Svgsplitter::CLI::Commands::SplitCommand < ACON::Command
  protected def configure : Nil
    self

      .argument("svg", :required, "SVG to split")
       .option("output", "o", :optional, description: "Output directory")
       .option("prefix", "p", :optional, description: "Prefix for new files")
       .option("dry-run", "d", :none)
  end

  protected def execute(input : ACON::Input::Interface, output : ACON::Output::Interface) : Status
    svg_path = input.argument "svg", String
    output_dir = input.option "output"
    prefix = input.option "prefix"
    dry_run = input.option "dry-run", Bool

    splitter = Splitter.new(svg_path, output_path: output_dir, prefix: prefix)
    splitter.run(dry_run)

    Status::SUCCESS
  end
end
