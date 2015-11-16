var React = require('<%= @node_path %>/react'),
    ReactDOMServer = require('<%= @node_path %>/react-dom/server'),
    props = <%= @props %>,
    App = React.createFactory(require('<%= @component %>')),
    result = ReactDOMServer.renderToString(App(props));

console.log(result);
