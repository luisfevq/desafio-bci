import 'package:flutter/material.dart';
import 'package:itunes/src/pages/home/home_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_player/video_player.dart';

class DetailPage extends StatefulWidget {
  final String nombre;
  final String previewUrl;

  DetailPage({this.nombre, this.previewUrl});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        print('OKOKOKOKOKOKOKOK');
        _controller.play();
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
              child: _controller.value.initialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            ),
            Text('Playing', style: TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }
}
