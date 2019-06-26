import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_streaming/meeting_bloc.dart';
import 'package:meeting_streaming/models/meeting_model.dart';

class MeetingCard extends StatelessWidget {
  const MeetingCard({Key key, @required this.meetingModel}) : super(key: key);

  final MeetingModel meetingModel;

  @override
  Widget build(BuildContext context) {
    MeetingBloc meetingBloc = BlocProvider.of<MeetingBloc>(context);
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: GestureDetector(
        onTap: (){
          meetingBloc.dispatch(FetchStreamEvent(meetingModel: meetingModel));
        },
        child: Card(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    bottom: 8.0,
                  ),
                  child: Text(
                    meetingModel.Title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    bottom: 8.0,
                  ),
                  child: Text(meetingModel.Description),
                ),
                Container(
                  child: Text(
                    meetingModel.scheduledTime,
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w400),
                  ),
                  // color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
