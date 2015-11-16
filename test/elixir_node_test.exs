defmodule ElixirNodeTest do
  use ExUnit.Case
  doctest ElixirNode

  require Logger
  @node_path Application.get_env(:elixir_node, :node_path)

  test "Working exec()  Example" do
    assert {:ok, "test\n"} = ElixirNode.exec("console.log('test');")
  end

  test "Not working exec() Example" do
    assert {:error, _result} = ElixirNode.exec("console.log(test);")
  end

  test "Working render_template() and node_path Example" do
    result = "test\nfoobar\n#{@node_path}\n"
    assert {:ok, ^result} = ElixirNode.render_template("foobar.js", [logmsg: "test", logmsg2: "foobar"], true)
  end

  test "Working render_template() Example" do
    result = "test\nfoobar\n\n"
    assert {:ok, ^result} = ElixirNode.render_template("foobar.js", [logmsg: "test", logmsg2: "foobar"], false)
  end

  test "Working react() Example" do
    test = ElixirNode.react(System.cwd() <> "/App.js", "{items: [
        'Item 0',
        'Item 1',
        'Item </script>',
        'Item <!--inject!-->',
      ]}")
    assert {:ok, _result} = test
  end

end
