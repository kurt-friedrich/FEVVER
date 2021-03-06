$(document).ready(function(){
  var musicPlayers = $('.mp')

  $(musicPlayers).each(function(i,musicPlayer){
    var mpAudio = $('.mp-audio', musicPlayer)[0],
        mpWaveform = $('#mp-waveform', musicPlayer)[0],
        mpPlayhead = $('.mp-visualizer-playhead', musicPlayer)[0],
        mpPlay = $('.mp-controls-play', musicPlayer)[0],
        mpRegion = $('wavesurfer-region', musicPlayer)[0],
        mpRestart = $('.mp-controls-restart', musicPlayer)[0],
        mpReplay = $('.mp-controls-replay', musicPlayer)[0],
        mpFast = $('.mp-controls-fast', musicPlayer)[0],
        mpSlow = $('.mp-controls-slow', musicPlayer)[0],
        mpLoop = $('.mp-controls-loop', musicPlayer)[0],
        mpTimeline = $('#mp-timeline', musicPlayer)[0]

    var waveSurfer = WaveSurfer.create({
        container: mpWaveform,
        cursorColor: '#333',
        progressColor: '#66ffc2',
        waveColor: '#595959',
        barWidth: 3,
        skipLength: 10,
        height: 100,
        autoCenter: true
    })

    waveSurfer.load(mpAudio.src)

    waveSurfer.on('ready', function (){
      $('#waveform-loading').hide()

      var timeline = Object.create(WaveSurfer.Timeline);
      timeline.init({
        wavesurfer: waveSurfer,
        container: mpTimeline
      })

      // Add a couple of pre-defined regions
      var region = waveSurfer.addRegion({
        start: 0, // time in seconds
        end: 20, // time in seconds
        color: 'rgba(38, 38, 38, 0.4)',
      })

      var loopStatus = region.loop

      // Looping
      mpLoop.addEventListener('click', function(){

        region.update({
          loop: !region.loop,
          color: !region.loop ? 'rgba(255, 255, 255, 0.4)' : 'rgba(38, 38, 38, 0.4)',
        })

        mpLoop.style.color = !region.loop ? '#262626' : '#00ff99'
      })
    })

    // Playing & Pausing
    mpPlay.addEventListener('click', function(){
      if (waveSurfer.isPlaying()) {
        mpPlay.innerHTML = '<i class="fi-play"></i>'
        waveSurfer.pause()
      }
      else {
        mpPlay.innerHTML = '<i class="fi-pause"></i>'
        waveSurfer.play()
      }
    })

    // Restarting
    mpRestart.addEventListener('click', function(){
      waveSurfer.seekTo(0)
    })

    // 10-Second Rewind
    mpReplay.addEventListener('click', function(){
      waveSurfer.skipBackward()
    })

    // Slow Speed
    mpSlow.addEventListener('click', function(){
      if (waveSurfer.backend.playbackRate == .5) {
        waveSurfer.setPlaybackRate(1)
        mpSlow.style.color = '#262626'
      }
      else if (waveSurfer.backend.playbackRate == 2) {
        waveSurfer.setPlaybackRate(.5)
        mpSlow.style.color = '#00ff99'
        mpFast.style.color = '#262626'
      }
      else {
        waveSurfer.setPlaybackRate(.5)
        mpSlow.style.color = '#00ff99'
      }
    })

    // Fast Speed
    mpFast.addEventListener('click', function(){
      if (waveSurfer.backend.playbackRate == 2) {
        waveSurfer.setPlaybackRate(1)
        mpFast.style.color = '#262626'
      }
      else if (waveSurfer.backend.playbackRate == .5) {
        waveSurfer.setPlaybackRate(2)
        mpSlow.style.color = '#262626'
        mpFast.style.color = '#00ff99'
      }
      else {
        waveSurfer.setPlaybackRate(2)
        mpFast.style.color = '#00ff99'
      }
    })
  })
})
