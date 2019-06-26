
import 'package:flutter_test/flutter_test.dart';
import 'package:meeting_streaming/respositories/meeting_repository.dart';

void main(){
  final MeetingRepository meetingRepository = MeetingRepository();
  test('Meeting Repository - fetch meeting list', () async {    
    await meetingRepository.initial();
    expect(meetingRepository.meetingList.length, greaterThan(0));
    print(meetingRepository.meetingList.length);
  });

  test('Meeting Repository - fetch meeting streams', () async {
    await meetingRepository.initial();
    expect(meetingRepository.meetingList.length, greaterThan(0));
    final meetingId = meetingRepository.meetingList[0].Id;
    print(meetingId);
    await meetingRepository.fetchMeetingStreamInfo(meetingId: meetingId);
    print(meetingRepository.meetingStreamMap[meetingId]);
  });
}