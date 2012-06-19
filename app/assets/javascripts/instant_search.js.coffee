$ ->
  # Make sure the cursor is at the end of the text.

  moveCaretToEnd = ( obj ) ->
    value = $( obj ).val()
    if value?
      $( obj ).focus().val( "" )
      $( obj ).focus().val( value )
      $( obj ).unbind()

  moveCaretToEnd( "input#search" )
  

  # Trigger search event. _.debounce postpones execution until after wait_ms
  # has elapsed since the last time it was invoked. 
  
  wait_ms = 1000

  $( "input#search" ).bind( 
    "textchange", 
    _.debounce( ( (event, previousText) -> $( "form.searchform" ).submit() ), wait_ms ) 
  )
  
  $( 'form.searchform' ).submit (event) ->
    event.preventDefault()
    $.pjax
      container: '[data-pjax-container]'
      url: @.action + "?" + $(@).serialize()
    return false
