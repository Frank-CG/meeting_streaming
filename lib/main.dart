import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_streaming/models/meeting_model.dart';
import 'package:meeting_streaming/respositories/meeting_repository.dart';
import 'package:meeting_streaming/widgets/meeting_card.dart';
import 'package:meeting_streaming/widgets/videoplayerscreen.dart';

import 'meeting_bloc.dart';
import 'simple_bloc_delegate.dart';

// void main() => runApp(MyApp());
void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final _meetingRepository = MeetingRepository();
  runApp(App(
    meetingRepository: _meetingRepository,
  ));
}

class App extends StatefulWidget {
  final MeetingRepository meetingRepository;

  const App({Key key, @required this.meetingRepository}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: <BlocProvider>[
        BlocProvider<MeetingBloc>(
          builder: (context) =>
              MeetingBloc(meetingRepository: widget.meetingRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Meeting Streaming',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              dialogBackgroundColor: Colors.white60,
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
