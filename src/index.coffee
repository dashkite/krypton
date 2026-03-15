import * as Fn from "@dashkite/joy/function"
import * as Time from "@dashkite/joy/time"
import $ from "@dashkite/zest"

import Page from "./helpers/page"
import View from "./helpers/view"


Krypton =

  page: ( render ) ->
    ({ data, url, bindings, context... }) ->
      name = data.name
      target = url.pathname + url.search
      page = Page.get name
      view = View.get page, target
      context = {
        context...
        name, data, url, target, bindings, render,
        page, view, pages: Page.list
      }
      context

  show: Fn.tee ( context ) ->
    do ({ render, view } = context ) ->
      ( $ "body" ).render render context
      view.html = ( $ View.selector view ).html
      view.initialized = true

  event: ( name, handler ) ->
    Fn.tee ({ initializing, view }) ->
      if !view.initialized
        ( $ document )
          .listen name
          .within View.selector view
          .apply handler

  success: ( handler ) -> Krypton.event "success", handler

  failure: ( handler ) -> Krypton.event "failure", handler

  dispose: Fn.tee ({ view, page, initializing }) ->
    if !view.initialized
      ( $ View.selector view )
        .hide -> Page.remove page, view

export default Krypton