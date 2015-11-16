defmodule ElixirNode do
    @docmodule false

    require Logger

    @react_template Application.get_env(:elixir_node, :react_template)
    @node_path Application.get_env(:elixir_node, :node_path)


    @doc """
    Sends the given JS String to node and returns the result
    """
    @spec exec(binary) :: {:ok, binary}
    @spec exec(binary) :: {:error, {integer, binary}}
    def exec(js) do
        filename = System.tmp_dir() <> "/" <> "_elixirnode_" <> Integer.to_string(:os.system_time) <> ".js"
        filename |> File.write(js)
        {result, exit_status} = System.cmd("node", [filename])
        File.rm(filename)
        case exit_status do
            0 -> {:ok, result}
            _ -> {:error, {exit_status, result}}
        end
    end

    def render_template(template, assigns, node_modules \\ false)
    def render_template(template, assigns, node_modules) when node_modules and is_binary(template) and is_list(assigns) do
        EEx.eval_file("node_templates" <> "/" <> template, assigns: [ {:node_path, @node_path} | assigns]) |> exec()
    end

    def render_template(template, assigns, node_modules) when not node_modules and is_binary(template) and is_list(assigns) do
        EEx.eval_file("node_templates" <> "/" <> template, assigns: assigns) |> exec()
    end

    def render_template(_template, _assigns, _node_path) do
        {:error, "Error render_template()"}
    end

    def react(component, props) do
        render_template(@react_template, [component: component, props: props], true)
    end

end
