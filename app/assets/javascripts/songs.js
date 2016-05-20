$(document).ready(function(){

  $(document).on("upload:start", "form", function(e) {
    $(this).find("input[type=submit]").attr("disabled", true)
    $('#song-upload').html("uploading song... <img src='/loading_images/waveform_load.gif' alt='' />")
  });

  $(document).on("upload:complete", "form", function(e) {
    if(!$(this).find("input.uploading").length) {
      $('#song-upload').hide()
      $(this).find("input[type=submit]").removeAttr("disabled")
    }
  })
})
