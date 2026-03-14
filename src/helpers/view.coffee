import * as Fn from "@dashkite/joy/function"

View =

  create: ( page, target ) ->
    view = { active: false, initialized: false, target }
    page.views.push view
    view

  find: ( page, target ) ->
    page.views.find ( view ) -> 
      target == view.target

  get: ( page, target ) ->
    ( View.find page, target ) ? ( View.create page, target )

  selector: ( view ) ->
    "[data-target='#{ view.target }']"


export default View