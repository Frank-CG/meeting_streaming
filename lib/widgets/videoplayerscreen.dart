import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_streaming/meeting_bloc.dart';
import 'package:meeting_streaming/models/meeting_model.dart';
import 'package:meeting_streaming/models/meeting_stream_model.dart';
import 'package:video_player/video_player.dart';

import 'material_controls.dart';

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
  MeetingBloc _meetingBloc;
  VideoPlayerController _controller;
  ChewieController _chewieController;

  @override
  void initState() {
    _meetingBloc = BlocProvider.of<MeetingBloc>(context);
    String _defaultUrl = _getUrl();
    if (_defaultUrl != null) {
      print("_defaultUrl=$_defaultUrl");
      _controller = VideoPlayerController.network(_defaultUrl);
      
      // _initializeVideoPlayerFuture = _controller.initialize();
      // _controller.setLooping(true);
      _chewieController = ChewieController(
        videoPlayerController: _controller,
        aspectRatio: 3 / 2,
        autoPlay: true,
        looping: true,
        customControls: MaterialControls(),
        // Try playing around with some of these other options:

        // showControls: false,
        // materialProgressColors: ChewieProgressColors(
        //   playedColor: Colors.red,
        //   handleColor: Colors.blue,
        //   backgroundColor: Colors.grey,
        //   bufferedColor: Colors.lightGreen,
        // ),
        // placeholder: Container(
        //   color: Colors.grey,
        // ),
        // autoInitialize: true,
      );
    }
    super.initState();
  }

  String _getUrl({audioOnly: false, language: 'en'}) {
    List<MeetingStreamModel> _meetingStreams = widget.meetingStreamModel;
    for (MeetingStreamModel ms in _meetingStreams) {
      if (ms.Lang == language && ms.AudioOnly == audioOnly) {
        return ms.Url;
      }
    }
    return null;
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_chewieController == null) {
      _meetingBloc.dispatch(FetchListEvent());
    } else {
      return WillPopScope(
        child: Chewie(
          controller: _chewieController,
        ),
        onWillPop: () {
          _meetingBloc.dispatch(FetchListEvent());
        },
      );
    }
  }
}
