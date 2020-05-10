## `jscl-react` is a library for writing React components in common lisp, using `jscl`

Here's a quick demo:

![](ss/out.gif)

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
	((btn) (object "id" "the-button" "class" "pretty-button"))
	"Isn't it pretty?"))
```

