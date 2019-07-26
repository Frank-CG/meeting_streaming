import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:meeting_streaming/models/meeting_model.dart';
import 'package:meeting_streaming/models/meeting_stream_model.dart';
import 'package:meeting_streaming/respositories/meeting_repository.dart';
import 'package:meta/meta.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  final MeetingRepository meetingRepository;

  MeetingBloc({@required this.meetingRepository});

  @override
  MeetingState get initialState => MeetingListInitialized();

  @override
  Stream<MeetingState> mapEventToState(
    MeetingEvent event,
  ) async* {
    if(event is FetchListEvent){
      yield MeetingListIsLoading();
      await meetingRepository.fetchMeetingList();
      yield MeetingListIsLoaded();
    }else if(event is FetchStreamEvent){
      yield MeetingStreamIsLoading();
      final meetingId = event.meetingModel.Id;
      await meetingRepository.fetchMeetingStreamInfo(meetingId: meetingId);
      yield MeetingStreamIsLoaded(meetingModel: meetingRepository.meetingMap[meetingId], meetingStreamModel: meetingRepository.meetingStreamMap[meetingId]);
    }
  }
}

@immutable
abstract class MeetingState extends Equatable {
  MeetingState([List props = const []]) : super(props);
}

class MeetingListInitialized extends MeetingState {
}

class MeetingListIsLoading extends MeetingState {
}

class MeetingListIsLoaded extends MeetingState {
}

class MeetingStreamIsLoading extends MeetingState {
}

class MeetingStreamIsLoaded extends MeetingState {
  final MeetingModel meetingModel;
  final List<MeetingStreamModel> meetingStreamModel;

  MeetingStreamIsLoaded({@required this.meetingModel, @required this.meetingStreamModel});
}


@immutable
abstract class MeetingEvent extends Equatable {
  MeetingEvent([List props = const []]) : super(props);
}

class FetchListEvent extends MeetingEvent {
}

class RefreshListEvent extends MeetingEvent {
}

class FetchStreamEvent extends MeetingEvent {
  final MeetingModel meetingModel;

  FetchStreamEvent({@required this.meetingModel});
}


