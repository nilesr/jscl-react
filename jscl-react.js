window.lispToJs = function(...args) {
  var o = {};
  for (var i = 0; i < args.length; i += 2)
    o[args[i]] = args[i+1]
  return o;
}
window.getObj = function(key, obj) {
  return obj[key];
}
window.makeComponent = (def, render, ...args) => {
  return (props) => {
    const [state, setState] = React.useState(def);
    return render(setState, state, props, ...args);
  }
}
window.preventDefault = (e) => e.preventDefault();
