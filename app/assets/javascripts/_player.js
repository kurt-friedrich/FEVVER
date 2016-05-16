$(document).ready(function(){
  var musicPlayers = $('.mp')

  $(musicPlayers).each(function(i,musicPlayer){
    var mpAudio = $('.mp-audio', musicPlayer)[0],
        mpVisualizer = $('.mp-visualizer', musicPlayer)[0],
        mpPlayhead = $('.mp-visualizer-playhead', musicPlayer)[0],
        mpPlay = $('.mp-controls-play', musicPlayer)[0],
        mpRestart = $('.mp-controls-restart', musicPlayer)[0],
        mpReplay = $('.mp-controls-replay', musicPlayer)[0],
        mpLoop = $('.mp-controls-loop', musicPlayer)[0],
        mpTimeline = $('.mp-timeline', musicPlayer)[0]

    var waveSurfer = WaveSurfer.create({
        container: mpVisualizer,
        cursorColor: '#333',
        progressColor: 'purple',
        waveColor: 'red',
        normalize: true,
        skipLength: 10
    })

    waveSurfer.load(mpAudio.src)

    waveSurfer.on('ready', function () {
      var timeline = Object.create(WaveSurfer.Timeline);
      timeline.init({
        wavesurfer: waveSurfer,
        container: mpTimeline
      });
    })

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

    // Looping
    mpLoop.addEventListener('click', function(){
      //mpAudio.
    })
  })
})
