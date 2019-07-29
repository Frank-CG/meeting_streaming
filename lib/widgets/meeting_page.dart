import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_streaming/models/meeting_model.dart';

import '../meeting_bloc.dart';
import 'meeting_card.dart';
import 'videoplayerscreen.dart';

class MeetingPage extends StatefulWidget {
  MeetingPage({Key key}) : super(key: key);

  _MeetingPageState createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  MeetingBloc _meetingBloc;
  
  @override
  void initState() { 
    super.initState();
    _meetingBloc = BlocProvider.of<MeetingBloc>(context);
    _meetingBloc.dispatch(FetchListEvent());
  }
    
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _meetingBloc,
      builder: (BuildContext context, MeetingState state) {
        if (state is MeetingListIsLoaded) {
          List<MeetingModel> meetings =
              _meetingBloc.meetingRepository.meetingList;
          // _meetingBloc.dispatch(FetchStreamEvent(meetingModel: meetings[0]));
          return Scaffold(
            appBar: AppBar(
              title: Text("June 18, 2019"),
            ),
            body: ListView.builder(
              itemCount: meetings.length,
              itemBuilder: (BuildContext context, int index) {
                return MeetingCard(
                  meetingModel: meetings[index],
                );
              },
            ),
          );
        } else if (state is MeetingListIsLoading) {
          return Scaffold(
            appBar: AppBar(
              title: Text("June 18, 2019"),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is MeetingStreamIsLoaded) {
          // return VideoPlayerScreen(
          //   meetingModel: state.meetingModel,
          //   meetingStreamModel: state.meetingStreamModel,
          // );
          return MaterialApp(
            title: '',
            theme: ThemeData(
              dialogBackgroundColor: Colors.white.withOpacity(0.6),
            ),
            home: VideoPlayerScreen(
              meetingModel: state.meetingModel,
              meetingStreamModel: state.meetingStreamModel,
            ),
          );
        } else if (state is MeetingStreamIsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}