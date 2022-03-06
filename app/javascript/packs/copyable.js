$(function(){
  $('.copyable').on('click', function(){
    var target_element = $(this.dataset['clipboardTarget'])[0]
    navigator.clipboard.writeText(target_element.textContent)
    if(this.dataset['bsToggle'] === 'popover'){
      var popover = new bootstrap.Popover(this, {
        trigger: 'focus'
      })
      popover.show()
    }
  })
})
