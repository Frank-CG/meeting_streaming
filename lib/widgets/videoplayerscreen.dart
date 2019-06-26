import 'package:flutter/material.dart';
import 'package:meeting_streaming/models/meeting_model.dart';
import 'package:meeting_streaming/models/meeting_stream_model.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  static const language = 'en';

  VideoPlayerScreen({
    Key key,
    @required this.meetingModel,
    @required this.meetingStreamModel,
  }) : super(key: key);

  final MeetingModel meetingModel;
  final List<MeetingStreamModel> meetingStreamModel;

  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    String _defaultUrl = _getUrl();
    if(_defaultUrl != null){
      _controller = VideoPlayerController.network(_defaultUrl);
      _initializeVideoPlayerFuture = _controller.initialize();
      _controller.setLooping(true);
    }
    super.initState();
  }

  String _getUrl({audioOnly:false,language:'en'}){
    List<MeetingStreamModel> _meetingStreams = widget.meetingStreamModel;
    for(MeetingStreamModel ms in _meetingStreams){
      if(ms.Lang == language && ms.AudioOnly == audioOnly){
        return ms.Url;
      }
    }
    return null;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Butterfly Video'),
      // ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
