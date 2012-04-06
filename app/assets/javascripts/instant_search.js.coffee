$( document ).ready ->

  # Make sure the cursor is at the end of the text.

  moveCaretToEnd = ( obj ) ->
    value = $( obj ).val()
    if value?
      $( obj ).focus().val( "" )
      $( obj ).focus().val( value )
      $( obj ).unbind()

  moveCaretToEnd( "input#search" )
  

  # Trigger search event

  wait_ms = 250
  submitSearch = ->
    $( "form.searchform" ).submit()

  # _.debounce postpones execution until after wait has elapsed since the last
  # time it was invoked. Thanks Rick Wong!
  $( "input#search" ).bind( "keyup", _.debounce( submitSearch, wait_ms ) )