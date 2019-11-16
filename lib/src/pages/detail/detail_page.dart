import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
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
  FlutterSound flutterSound = new FlutterSound();

  bool _loading = false;
  bool paused = false;
  bool playing = false;

  Icon iconPlay = Icon(
    Icons.play_arrow,
    color: Colors.white,
  );
  Icon iconPause = Icon(
    Icons.pause,
    color: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    print(widget.previewUrl);
  }

  @override
  void dispose() {
    flutterSound.stopPlayer();
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
                width: double.infinity, height: 200.0, child: Container()),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: Row(
                children: <Widget>[
                  Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: iconPlay,
                        onPressed: () async {
                          if (paused) {
                            flutterSound.resumePlayer();
                            setState(() {
                              iconPlay = iconPause;
                              paused = false;
                              playing = true;
                            });
                          } else {
                            if (iconPlay.icon == Icons.play_arrow) {
                              if (!playing) {
                                await flutterSound
                                    .startPlayer(widget.previewUrl);
                              }
                              flutterSound.onPlayerStateChanged
                                  .listen((onData) {
                                if (onData == null) {
                                  setState(() {
                                    iconPlay = Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                    );
                                    flutterSound.stopPlayer();
                                    paused = false;
                                    playing = false;
                                  });
                                }
                              });
                              setState(() {
                                iconPlay = iconPause;
                                paused = false;
                                playing = true;
                              });
                            } else {
                              flutterSound.pausePlayer();
                              setState(() {
                                iconPlay = Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                );
                                paused = true;
                                playing = true;
                              });
                            }
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
