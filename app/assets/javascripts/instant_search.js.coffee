$ ->
  # Don't let the user enter text while we refresh the page.

  enableSearch = ( isEnabled ) ->
      $( "input#search" ).attr( "disabled", not isEnabled )


  # Make sure the cursor is at the end of the text.

  moveCaretToEnd = ( obj ) ->
    value = $( obj ).val()
    if value?
      $( obj ).focus().val( "" )
      $( obj ).focus().val( value )
      $( obj ).unbind()  

  enableSearch( true )
  moveCaretToEnd( "input#search" )

  # Trigger search event. _.debounce postpones execution until after wait_ms
  # has elapsed since the last time it was invoked. 
  
  wait_ms = 1250

  $( "input#search.index" ).bind( 
    "textchange", 
    _.debounce( 
      ( ( event, previousText ) ->
        $( "form.searchform.index" ).submit()
        enableSearch( false )
      ),
      wait_ms 
    ) 
  )