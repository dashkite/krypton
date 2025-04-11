import * as Fn from "@dashkite/joy/function"
import * as DOM from "@dashkite/dominator"

import Page from "./helpers/page"
import View from "./helpers/view"

# TODO optimize event handling
#      we can handle events at the page level
#      allowing us to us Fn.once instead of
#      checking an initialization flag, but
#      we need a similar trick for deactivate

Krypton =

  page: ( render ) ->
    ({ data, url, bindings }) ->
      name = data.name
      target = url.pathname + url.search
      page = Page.get name
      view = View.get page, target
      context = {
        name, data, url, target, bindings, render,
        page, view, pages: Page.list
      }
      context

  show: Fn.tee ( context ) ->
    do ({ render, page, view } = context ) ->
      performance.mark "render-start"
      await DOM.render "body", render context
      view.html = DOM.html View.selector view
      performance.mark "render-finish"
      measure = performance.measure "render", 
        "render-start", "render-finish"
      console.log "%ckrypton: 
        rendered view in
        #{ Math.round measure.duration }ms",
        "color: cyan;"
      view.initialized = true

  event: ( name, handler ) ->
    Fn.tee ({ initializing, view }) ->
      if !view.initialized
        DOM.listen document.body, name, ( event ) ->
          if DOM.within ( View.selector view ), event
            handler event

  success: ( handler ) -> Krypton.event "success", handler

  failure: ( handler ) -> Krypton.event "failure", handler

  dispose: Fn.tee ({ view, page, initializing }) ->
    if !view.initialized
      DOM.deactivate ( View.selector view ), ->
        Page.remove page, view

export default Krypton