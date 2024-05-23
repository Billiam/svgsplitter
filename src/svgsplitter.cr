#!/usr/bin/env crystal

# Require the component and anything extra needed based on your business logic.
require "athena-console"

require "./svgsplitter"
require "./svgsplitter/cli/**"

module Svgsplitter
  VERSION = "0.1.1"
end

app = ACON::Application.new "Svg Splitter"

app.add Svgsplitter::CLI::Commands::SplitCommand.new

app.run
