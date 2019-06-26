import 'package:http/http.dart' as http;
import 'package:meeting_streaming/models/meeting_model.dart';
import 'package:meeting_streaming/models/meeting_stream_model.dart';
import 'meeting_api_client.dart';

class MeetingRepository {
  final MeetingApiClient _meetingApiClient = MeetingApiClient(
    httpClient: http.Client(),
  );

  List<MeetingModel> _meetingList;
  DateTime _expiredTime;
  Map<int, MeetingModel> _meetingMap;
  Map<int, List<MeetingStreamModel>> _meetingStreamMap;

  List<MeetingModel> get meetingList => _meetingList;
  Map<int, MeetingModel> get meetingMap => _meetingMap;
  Map<int, List<MeetingStreamModel>> get meetingStreamMap => _meetingStreamMap;

  Future<void> initial() async {
    if (_meetingMap == null) {
      _meetingMap = new Map<int, MeetingModel>();
    }
    if (_meetingStreamMap == null) {
      _meetingStreamMap = new Map<int, List<MeetingStreamModel>>();
    }
    await _meetingApiClient.fetchMeetingList().then((onValue) {
      _meetingList = onValue;
      for (MeetingModel m in _meetingList) {
        _meetingMap.putIfAbsent(m.Id, () => m);
      }
    });
    _expiredTime = DateTime.now().add(Duration(
      seconds: 120,
    ));
  }

  Future<void> fetchMeetingList({forceRefresh: false}) async {
    if (forceRefresh) {
      await initial();
    }
    DateTime _current = DateTime.now();
    if (_meetingList == null || _current.isAfter(this._expiredTime)) {
      await initial();
    }
  }

  Future<void> fetchMeetingStreamInfo({meetingId}) async {
    if (!_meetingStreamMap.containsKey(meetingId)) {
      await _meetingApiClient
          .fetchMeetingStreamInfo(meetingId: meetingId)
          .then((onValue) {
        _meetingStreamMap.putIfAbsent(meetingId, () => onValue);
      });
    }
  }
}
