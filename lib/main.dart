import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_streaming/app_conifg.dart';
import 'package:meeting_streaming/models/meeting_model.dart';
import 'package:meeting_streaming/navigate_bloc.dart';
import 'package:meeting_streaming/respositories/meeting_repository.dart';
import 'package:meeting_streaming/widgets/meeting_card.dart';
import 'package:meeting_streaming/widgets/meeting_page.dart';
import 'package:meeting_streaming/widgets/videoplayerscreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'meeting_bloc.dart';
import 'simple_bloc_delegate.dart';
import 'widgets/notification_page.dart';

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
        BlocProvider<NavBloc>(
          builder: (BuildContext context) => NavBloc(),
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
  NavBloc _navBloc;

  @override
  void initState() {
    super.initState();
    _navBloc = BlocProvider.of<NavBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    AppConfig.instance = AppConfig()..init(context);

    return BlocBuilder(
      bloc: _navBloc,
      builder: (BuildContext context, NavState state) {
        Widget _bodyWidget;
        switch (state.pageName) {
          case RouteName.Meeting:
            _bodyWidget = MeetingPage(); 
            break;
          case RouteName.Notification:
            _bodyWidget = PushMessagingExample();
            break;
          default:
            _bodyWidget = Container();
            break;
        }
        final _barItems = state.pageNavBarItem;
        final _bottomBarWidget = BottomNavigationBar(
                onTap: (int index) {
                  _navBloc.dispatch(NavTo(
                      pageName: RouteName.values[index],
                      previousPageName: state.pageName));
                },
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: _barItems,
              );

        return Scaffold(
          body: _bodyWidget,
          bottomNavigationBar: _bottomBarWidget,
        );
      },
    );
  }
}
