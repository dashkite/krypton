# Krypton

*Page and view management for single-page applications.*

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

Krypton manages the lifecycle and context for application pages and views. It provides a structured way to handle page-specific data, view states, and cleanup, ensuring that each page has access to its relevant metadata and helpers.

## Installation

Use your favorite package manager:

```bash
npm install @dashkite/krypton
```

## Usage

Krypton is typically used as part of a navigation pipeline. The `page` function creates a context that is passed to your rendering logic.

```coffeescript
import Kr from "@dashkite/krypton"
import { pipe } from "@dashkite/joy/function"

# A render function that receives the Krypton context
render = (context) ->
  # return your VDOM or HTML
  # context includes page, view, bindings, etc.

# Use Kr.page to wrap your render function
apply = pipe [
  Kr.page render
  Kr.show
]
```

## Other Resources

- [Reference](docs/reference.md)
- [Recipes](docs/recipes.md)

## Status

Not suitable for production use. Please report any issues on the [GitHub repository](https://github.com/dashkite/krypton).
