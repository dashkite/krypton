# Reference

## Krypton.page

$Krypton.page: render \to (context \to context)$

Wraps a render function to provide it with a page and view context. The returned function accepts a navigation context and returns an enriched context object.

The enriched context includes:
- `name`: The name of the page.
- `data`: The page data from the registry.
- `url`: The current URL.
- `target`: The pathname and search string.
- `bindings`: Any captured URL bindings.
- `render`: The original render function.
- `page`: The internal page state object.
- `view`: The internal view state object.
- `pages`: The list of all managed pages.

## Krypton.show

$Krypton.show: context \to context$

Renders the page view to the document body and marks the view as initialized.

## Krypton.event

$Krypton.event: (name, handler) \to (context \to context)$

Registers an event listener for the current view. The listener is scoped to the view's container and is only registered once.

## Krypton.success / Krypton.failure

$Krypton.success: handler \to (context \to context)$
$Krypton.failure: handler \to (context \to context)$

Convenience wrappers for `Krypton.event` for handling `"success"` and `"failure"` events.

## Krypton.dispose

$Krypton.dispose: context \to context$

Performs cleanup for a view, including hiding its element and removing it from the page's view list.
