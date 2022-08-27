import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class VideoScreen extends StatefulWidget {
  final String videoName, videoUrl;

  VideoScreen({required this.videoName, required this.videoUrl});

  @override
  _videoScreen createState() => _videoScreen();
}

class _videoScreen extends State<VideoScreen> {
  late BetterPlayerController _betterPlayerController;

  final GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState

    BetterPlayerConfiguration bpcfg = const BetterPlayerConfiguration(
      fit: BoxFit.contain,
      aspectRatio: 16 / 9,
    );
    BetterPlayerDataSource bpdsrc = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, widget.videoUrl);
    _betterPlayerController = BetterPlayerController(bpcfg);
    _betterPlayerController.setupDataSource(bpdsrc);
    _betterPlayerController.setBetterPlayerGlobalKey(_globalKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.videoName),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 6,
          ),
          Expanded(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                // Defines the ratio of horizontal and vertical axis of the playing screen.
                child: BetterPlayer(
                  key: _globalKey,
                  controller: _betterPlayerController,
                ),
              ))
        ],
      ),
    );
  }
}
