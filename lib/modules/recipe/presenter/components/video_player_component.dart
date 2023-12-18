import 'dart:io';

import 'package:flutter/material.dart';
import 'package:minha_receita/design_system/containers/custom_container.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPlayerWidget extends StatefulWidget {
  final File? videoFile;
  final String? url;
  static double volume = 0;
  const VideoPlayerWidget({Key? key, this.videoFile, this.url})
      : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    if (widget.url != null) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url!));
    } else {
      assert(widget.videoFile != null, 'videoFile is null');
      _controller = VideoPlayerController.file(widget.videoFile!);
    }
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration) {
      setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(_controller.value.isPlaying){
          _controller.pause();
        }else{
          _controller.play();
        }
        setState(() {});
      },
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return VisibilityDetector(
                      key: Key(widget.url ?? widget.videoFile!.path),
                      onVisibilityChanged: (visibilityInfo) {
                        var visiblePercentage =
                            visibilityInfo.visibleFraction * 100;
                        if (visiblePercentage > 50) {
                          _controller.setVolume(VideoPlayerWidget.volume);
                          _controller.play();
                          if(mounted){
                            setState(() {});
                          }
                        } else {
                          _controller.pause();
                        }
                      },
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              if(_controller.value.isPlaying)
              Positioned(
                bottom: 16,
                right: 16,
                child: InkWell(
                  onTap: () {
                    VideoPlayerWidget.volume = _controller.value.volume == 0 ? 1.0 : 0.0;
                    _controller
                        .setVolume(VideoPlayerWidget.volume);
                    setState(() {});
                  },
                  child: DSCustomContainer(
                    circularRadius: 30,
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: Icon(
                        size: 16,
                        VideoPlayerWidget.volume == 0
                            ? Icons.volume_off
                            : Icons.volume_up,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              if(!_controller.value.isPlaying && _controller.value.duration > _controller.value.position)
              Center(
                child: DSCustomContainer(
                  circularRadius: 80,
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: Icon(
                      size: 50,
                          Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
