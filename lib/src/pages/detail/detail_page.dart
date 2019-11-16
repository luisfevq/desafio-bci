import 'package:flutter/material.dart';
import 'package:flutter_playout/audio.dart';
import 'package:flutter_playout/player_state.dart';
import 'package:itunes/src/pages/home/home_page.dart';
import 'package:page_transition/page_transition.dart';

class DetailPage extends StatefulWidget {
  final String nombre;
  final String previewUrl;

  DetailPage({this.nombre, this.previewUrl});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Audio _audioPlayer;
  PlayerState audioPlayerState = PlayerState.STOPPED;
  bool _loading = false;

  Duration duration = Duration(milliseconds: 1);
  Duration currentPlaybackPosition = Duration.zero;

  get isPlaying => audioPlayerState == PlayerState.PLAYING;
  get isPaused =>
      audioPlayerState == PlayerState.PAUSED ||
      audioPlayerState == PlayerState.STOPPED;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';
  get positionText => currentPlaybackPosition != null
      ? currentPlaybackPosition.toString().split('.').first
      : '';

  @override
  void initState() {
    super.initState();
    print(widget.previewUrl);
    _audioPlayer = new Audio();
  }

  void onPlay() {
    setState(() {
      audioPlayerState = PlayerState.PLAYING;
      _loading = false;
    });
  }

  @override
  void onPause() {
    setState(() {
      audioPlayerState = PlayerState.PAUSED;
    });
  }

  @override
  void onComplete() {
    setState(() {
      audioPlayerState = PlayerState.PAUSED;
      currentPlaybackPosition = Duration.zero;
    });
  }

  @override
  void onTime(int position) {
    setState(() {
      currentPlaybackPosition = Duration(seconds: position);
    });
  }

  @override
  void onDuration(int duration) {
    setState(() {
      this.duration = Duration(milliseconds: duration);
    });
  }

  Widget _buildPlayerControls() {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 11.0, 0.0, 0.0),
                margin: EdgeInsets.all(7.0),
                child: Stack(
                  children: <Widget>[
                    IconButton(
                      padding: EdgeInsets.all(0.0),
                      splashColor: Colors.transparent,
                      icon: Icon(
                        isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_filled,
                        color: Colors.white,
                        size: 47,
                      ),
                      onPressed: () {
                        if (isPlaying) {
                          pause();
                        } else {
                          play();
                        }
                      },
                    ),
                    _loading
                        ? Positioned.fill(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(7.0, 11.0, 5.0, 3.0),
                    child: Text('Musica titulo 2',
                        style:
                            TextStyle(fontSize: 11, color: Colors.grey[100])),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(7.0, 0.0, 5.0, 0.0),
                    child: Text('Subtitulo 2',
                        style: TextStyle(fontSize: 19, color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
          Container(
            height: 15.0,
          ),
          Slider(
            activeColor: Colors.white,
            value: currentPlaybackPosition?.inMilliseconds?.toDouble() ?? 0.0,
            onChanged: (double value) {
              setState(() {
                currentPlaybackPosition = Duration(milliseconds: value.toInt());
              });
              seekTo(value / 1000);
            },
            min: 0.0,
            max: duration.inMilliseconds.toDouble(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(),
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: Text(
                  _playbackPositionString(),
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  String _playbackPositionString() {
    var currentPosition = Duration(
        seconds: duration.inSeconds - currentPlaybackPosition.inSeconds);

    return currentPosition.toString().split('.').first;
  }

  // Request audio play
  Future<void> play() async {
    setState(() {
      _loading = true;
    });
    // here we send position in case user has scrubbed already before hitting
    // play in which case we want playback to start from where user has
    // requested
    print(currentPlaybackPosition);
    _audioPlayer.play('https://mp3teca.com/-/2019/10/Daddy-Yankee-Que-Tire-Pa-Lante.mp3',
        title: 'Musica titulo',
        subtitle: 'Subtitulo',
        position: currentPlaybackPosition,
        isLiveStream: true);
  }

  // Request audio pause
  Future<void> pause() async {
    _audioPlayer.pause();
    setState(() => audioPlayerState = PlayerState.PAUSED);
  }

  // Request audio stop. this will also clear lock screen controls
  Future<void> stop() async {
    _audioPlayer.stop();

    setState(() {
      audioPlayerState = PlayerState.STOPPED;
      currentPlaybackPosition = Duration.zero;
    });
  }

  // Seek to a point in seconds
  Future<void> seekTo(double seconds) async {
    _audioPlayer.seekTo(seconds);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181818),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: HomePage()));
              },
            );
          },
        ),
        title: Text(widget.nombre),
      ),
      body: Container(
        width: double.infinity,
        height: 400.0,
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200.0,
              child: _buildPlayerControls(),
            ),
            Text(
              'Playing',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
