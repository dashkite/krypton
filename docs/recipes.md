# Recipes

## Defining a Page

Use `Kr.page` to prepare the context for your views. This is typically done when registering a page with a router like Monterey.

```coffeescript
import Kr from "@dashkite/krypton"
import { pipe } from "@dashkite/joy/function"

html = (context) ->
  # your view logic here

pages.add "/my-page",
  name: "my page"
  apply: pipe [
    Kr.page html
    Kr.show
  ]
```

## Handling View Events

You can use `Kr.event` to attach behavior to your views. Krypton ensures these are scoped correctly.

```coffeescript
import Kr from "@dashkite/krypton"
import { pipe } from "@dashkite/joy/function"

handleSave = (event) ->
  # save logic

apply = pipe [
  Kr.page html
  Kr.event "click", handleSave
  Kr.show
]
```
