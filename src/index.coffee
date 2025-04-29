import * as Fn from "@dashkite/joy/function"
import * as Time from "@dashkite/joy/time"
import * as DOM from "@dashkite/dominator"

import Page from "./helpers/page"
import View from "./helpers/view"


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
      await DOM.flash "body", render context
      view.html = DOM.html View.selector view
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
      DOM.hide ( View.selector view ), ->
        Page.remove page, view

export default Krypton