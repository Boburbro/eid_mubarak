import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final VideoPlayerController _controller;
  final ConfettiController _confettiController = ConfettiController();

  @override
  void initState() {
    _controller = VideoPlayerController.asset(
      "assets/video.mp4",
    )..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
    _confettiController.play();
    playMusic();
    super.initState();
  }

  void playMusic() {
    final player = AudioPlayer(playerId: "audio_id");
    // await player.play(AssetSource("assets/music.mp3"));
    player.play(UrlSource(
        "https://github.com/rafaelreis-hotmart/Audio-Sample-files/raw/master/sample.mp3"));
    player.setReleaseMode(ReleaseMode.loop);
    // await player.setSourceAsset('assets/music.mp3');
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: 0.6,
              child: VideoPlayer(_controller),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 150),
                    Text(
                      "Eid",
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontFamily: GoogleFonts.specialElite().fontFamily,
                      ),
                    ),
                    Text(
                      "Mubarak 1445 H",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontFamily: GoogleFonts.specialElite().fontFamily,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width - 100,
                      height: 3,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Ushbu hayit bayrami baxt, shodlik, \nAllohning marhamati va muhabbatini \nolib kelsin. Sizga va oilangizga \nQURBON HAYITI MUBORAK bo'lsin.",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(),
              ConfettiWidget(
                shouldLoop: true,
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: 0.02,
                numberOfParticles: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
