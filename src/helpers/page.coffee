import * as Fn from "@dashkite/joy/function"

pages = []

Page =

  list: pages

  create: ( name ) ->
    page = { name, active: false, views: []}
    pages.push page
    page

  find: ( name ) ->
    pages.find ( page ) -> page.name == name

  get: ( name ) ->
    ( Page.find name  ) ? ( Page.create name )
    
  remove: Fn.tee ( page, view ) ->
    Arr.remove view, page.views


export default Page