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

  moveCaretToEnd( "input#search" )
  

  # Trigger search event. _.debounce postpones execution until after wait_ms
  # has elapsed since the last time it was invoked. 
  
  wait_ms = 1000

  $( "input#search" ).bind( 
    "textchange", 
    _.debounce( 
      ( ( event, previousText ) ->
        $( "form.searchform" ).submit()        
        enableSearch( false ) if not $.support.pjax
      ),
      wait_ms 
    ) 
  )
  
  if $.support.pjax
    $( "form.searchform" ).submit ( event ) ->
      event.preventDefault()      
      $.pjax
        container: '[data-pjax-container]'
        url: @.action + "?" + $( @ ).serialize()
      console.log( @.action + "?" + $( @ ).serialize() )
      return false
  
  enableSearch( true )