import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:itunes/src/pages/home/home_page.dart';
import 'package:page_transition/page_transition.dart';

class DetailPage extends StatefulWidget {
  final String nombre;
  final String previewUrl;
  final String imagen;
  final String artista;
  final String descripcion;
  final String genero;
  final String precio;

  DetailPage(
      {this.nombre,
      this.previewUrl,
      this.imagen,
      this.artista,
      this.descripcion,
      this.genero,
      this.precio});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  FlutterSound flutterSound = new FlutterSound();

  bool paused = false;
  bool playing = false;

  double currentTime = 0.0;
  double duration = 30.0;

  Icon iconPlay = Icon(
    Icons.play_arrow,
    color: Colors.white,
    size: 30.0,
  );
  Icon iconPause = Icon(
    Icons.pause,
    color: Colors.white,
    size: 30.0,
  );

  @override
  void initState() {
    super.initState();
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
                width: double.infinity,
                height: 140.0,
                child: Image.network(widget.imagen)),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                setState(() {
                                  currentTime = onData.currentPosition
                                          .truncateToDouble() /
                                      1000;
                                });
                                if (onData.duration == onData.currentPosition) {
                                  setState(() {
                                    iconPlay = Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 30.0,
                                    );
                                    currentTime = 30.0;
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
                                  size: 30.0,
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
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 60.0,
                        ),
                        Text(
                          currentTime.toStringAsFixed(2) + '  Seg.',
                          style: TextStyle(color: Color(0xFF00E04A)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.artista,
              style: TextStyle(
                color: Color(0xFFFAF3FF),
                fontSize: 40.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              widget.descripcion,
              style: TextStyle(
                color: Color(0xFF97999B),
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 15.0),
              child: Text(
                widget.genero,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              '\$ ' + widget.precio,
              style: TextStyle(
                color: Color(0xFF00E04A),
                fontSize: 14.0,
                fontWeight: FontWeight.w800
              ),
            ),
          ],
        ),
      ),
    );
  }
}
