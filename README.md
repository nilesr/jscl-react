## `jscl-react` is a library for writing React components in common lisp, using `jscl`

Here's a quick demo:

![](ss/out.gif)

The demo application is available to try out [here](https://niles.xyz/jscl-react-demo)

### Reference app demos

I've recreated two of the official React example applications in `jscl-react` to show it off

#### Emoji Search

Original project: [ahfarmer/emoji-search](https://github.com/ahfarmer/emoji-search), running live [here](https://ahfarmer.github.io/emoji-search)

`jscl-react` version running [here](https://niles.xyz/jscl-react-demo/emoji-search), source code in the [`emoji-search` subdirectory](https://github.com/nilesr/jscl-react/tree/master/emoji-search)

The original project uses `import` on a json file to make the contents of that file available at runtime, embedded in the code via Babel. I do the same, by loading `cl-json` at compile time using quicklisp, and storing the parsed contents of the json file in a variable that is then available at runtime. You can see exactly how I did this in [`emoji-search/filter-emoji.lisp`](https://github.com/nilesr/jscl-react/blob/master/emoji-search/filter-emoji.lisp#L1-L8). Alternative ways to do it could have included loading it into a variable as a string and using the browser's `JSON.parse` at runtime, which would have eliminated the need for quicklisp, or fetching it at runtime using the browser's built-in `fetch` or `XMLHttpRequest`.

#### Counter App

Original project: [arnab-datta/counter-app](https://github.com/arnab-datta/counter-app/), running live [here](https://obscure-waters-60500.herokuapp.com/)

`jscl-react` version running [here](https://niles.xyz/jscl-react-demo/counter-app), source code in the [`counter-app` subdirectory](https://github.com/nilesr/jscl-react/tree/master/counter-app)

### Creating React elements

The shortcut `react-create-element` is provided for the JavaScript function `React.createElement`. For example:

```
(react-create-element
	"div"
	#()
	(react-create-element "h1" #() "I'm big!")
	"I'm a text node!"
	(react-create-element "br")
	(react-create-element "button" (object "onClick" #j:window:alert) "Click me!"))
```

The macro `render` is provided to recurse on child elements, where appropriate. The above call can be rewritten as:

```
(render
	"div"
	#()
	("h1" #() "I'm big!")
	"I'm a text node!"
	("br")
	("button" (object "onClick" #j:window:alert) "Click me!"))
```

### Mounting React elements

Given a mount element like a div with an id, you can place a react element in it like so

```
(mount "the-id" (react-create-element "h1" #() "Hello, world!"))
```

Defining a component is as simple as this:

```
(defcomponent (btn 0) (set-state state props)
  (let ((handler (lambda (event)
                   (funcall set-state (1+ state)))))
    (render
      "button"
      (object "onClick" handler)
      "Hello, world: "
      state)))
```

Here, `btn` is the name of the component, and `0` is the initial state. The rest of the definition is the `render` function for the component, accepting `set-state` (the function called to update the state), `state`, and `props`.

This component's state is a single number. Clicking the returned button increments the state by 1, which is reflected in the text of the button

The name of the component should be invoked to create one, which can then be passed to `create-react-element` or `render`. So we can render a `btn` to the screen like so

```
(mount "root" (render
	"div"
	#()
	("h3" #() "Here is my cool button:")
	((btn))
	"Isn't it pretty?"))
```

Properties should be passed in the way `React.createElement` expects them, like so

```
(mount "root" (render
	"div"
	#()
	("h3" #() "Here is my cool button:")
	((btn) (object "id" "the-button" "className" "pretty-button"))
	"Isn't it pretty?"))
```

