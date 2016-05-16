$(document).ready(function(){
  var musicPlayers = $('.mp')

  $(musicPlayers).each(function(i,musicPlayer){
    var mpAudio = $('.mp-audio', musicPlayer)[0],
        mpVisualizer = $('.mp-visualizer', musicPlayer)[0],
        mpPlayhead = $('.mp-visualizer-playhead', musicPlayer)[0],
        mpPlay = $('.mp-controls-play', musicPlayer)[0],
        mpRestart = $('.mp-controls-restart', musicPlayer)[0],
        mpReplay = $('.mp-controls-replay', musicPlayer)[0],
        mpLoop = $('.mp-controls-loop', musicPlayer)[0]

    var waveSurfer = WaveSurfer.create({
        container: mpVisualizer,
        cursorColor: '#333',
        progressColor: 'purple',
        waveColor: 'red',
        normalize: true,
        skipLength: 10
    })

    waveSurfer.load(mpAudio.src)

    // Playing & Pausing
    mpPlay.addEventListener('click', function(){
      if (waveSurfer.isPlaying()) {
        mpPlay.innerHTML = 'PLAY'
        waveSurfer.pause()
      }
      else {
        mpPlay.innerHTML = 'PAUSE'
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

    // Visualizer
    // mpAudio.addEventListener('timeupdate', function(e){
    //   var mpPlayheadPosition = (mpAudio.currentTime / mpAudio.duration) * 100,
    //       mpPlayheadPercentWidth = ($(mpPlayhead).width() / $(mpVisualizer).width() * 100)
    //
    //   if (mpPlayheadPosition + mpPlayheadPercentWidth < 100) {
    //     mpPlayhead.style.left = mpPlayheadPosition + '%'
    //   }
    // })

    // Playhead Positioning
    // mpVisualizer.addEventListener('click', function(e){
    //   var mousePointerX = e.pageX,
    //       mpVisualizerX = $(this).offset().left,
    //       mpVisualizerWidth = $(this).width() + $(mpPlayhead).width(),
    //       mpPlayheadPercent = ((mousePointerX - mpVisualizerX) / mpVisualizerWidth) * 100
    //
    //   mpPlayhead.style.left = mpPlayheadPercent + '%'
    //   mpAudio.currentTime = (mpPlayheadPercent / 100) * mpAudio.duration
    // })
    //
    //
    //
    // // Looping
    // mpLoop.addEventListener('click', function(){
    //   //mpAudio.
    // })
  })
})
