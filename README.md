# ElixirNode

Running Javascript in Elixir using *node.js*. As I think, this currently not really efficient.
The Javascript String is currently written into a file and then run by node. So you need `console.log(result)` to get the result back in to elixir.

For examples please have a look at `test/`.

## Installation

  1. Add elixir_node to your list of dependencies in `mix.exs`:

        def deps do
          [{:elixir_node, "~> 0.0.1"}]
        end

  2. Ensure elixir_node is started before your application:

        def application do
          [applications: [:elixir_node]]
        end

  3. Setup your vars in `config/config.exs`:

        config :elixir_node,
          react_template: "react_template.js",
          node_path: System.cwd <> "/node_modules"

  4. Run `npm install`:
