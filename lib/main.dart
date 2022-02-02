import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicApp(),
    );
  }
}

class MusicApp extends StatefulWidget {
  const MusicApp({Key? key}) : super(key: key);

  @override
  State<MusicApp> createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  bool playing = false;
  IconData playbtn = Icons.play_arrow;

  late AudioPlayer _player;
  late AudioCache cache;

  // AssetsAudioPlayer player = AssetsAudioPlayer();

  Duration position = new Duration();
  Duration musicLength = new Duration();

  Widget slider() {
    return Container(
      width: 300.0,
      child: Slider.adaptive(
          activeColor: Color(0xfffa386d),
          inactiveColor: Colors.grey.shade300,
          value: position.inSeconds.toDouble(),
          max: musicLength.inSeconds.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player.onDurationChanged.listen((Duration d) {
      setState(() {
        musicLength = d;
      });
    });

    _player.onAudioPositionChanged.listen((Duration p) => {
          setState(() {
            position = p;
          })
        });

    cache.load("saath.mp3");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xfff996cf), Color(0xfffa386d)])),
        child: Padding(
          padding: EdgeInsets.only(top: 48.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Music Beats",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 38.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Listen to your favroite music",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Center(
                  child: Container(
                    width: 280.0,
                    height: 280.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        image: DecorationImage(
                            image: AssetImage("assets/saath.jpg"))),
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Center(
                  child: Text(
                    "Main Hoon Saath Tere",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Center(
                  child: Text(
                    "Singer: Arijit Singh",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 500.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${position.inMinutes}:${position.inSeconds.remainder(60)}",
                              style: TextStyle(
                                  fontSize: 18.0, color: Color(0xfff996cf)),
                            ),
                            slider(),
                            Text(
                              "${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}",
                              style: TextStyle(
                                  fontSize: 18.0, color: Color(0xfff996cf)),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            iconSize: 45.0,
                            color: Color(0xfff996cf),
                            icon: Icon(
                              Icons.skip_previous,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            iconSize: 62.0,
                            color: Color(0xfffa386d),
                            icon: Icon(playbtn),
                            onPressed: () {
                              if (!playing) {
                                cache.play('saath.mp3');
                                setState(() {
                                  playbtn = Icons.pause;
                                  playing = true;
                                });
                              } else {
                                _player.pause();
                                setState(() {
                                  playbtn = Icons.play_arrow;
                                  playing = false;
                                });
                              }
                            },
                          ),
                          IconButton(
                            iconSize: 45.0,
                            color: Color(0xfff996cf),
                            icon: Icon(Icons.skip_next),
                            onPressed: () {},
                          ),
                        ],
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
