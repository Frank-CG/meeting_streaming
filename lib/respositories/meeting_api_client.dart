import 'dart:convert';
import 'dart:async';
import 'dart:math';

import 'package:meeting_streaming/models/meeting_model.dart';
import 'package:meeting_streaming/models/meeting_stream_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class MeetingApiClient {
  static const baseUrl = 'http://parlvucloud.parl.gc.ca/Harmony/';
  static const language = 'en';
  final http.Client httpClient;

  MeetingApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List<MeetingModel>> fetchMeetingList() async {
    final _url = '$baseUrl/$language/api/data/GetEventList?maxCount=-1&fromdate=20190618&enddate=20190618';
    final _response = await this.httpClient.get(_url);

    if (_response.statusCode != 200) {
      throw Exception('error getting menu for location');
    }

    final responseJson = jsonDecode(_response.body);
    final entities = (responseJson as Map<String, dynamic>)['ContentEntityDatas'] as List;
    return entities.map((e) => e == null ? null : MeetingModel.fromJson(e as Map<String,dynamic>))?.toList();
  }

  Future<List<MeetingStreamModel>> fetchMeetingStreamInfo({meetingId}) async {
    final _url = '$baseUrl/$language/api/PowerBrowserData/GetStreamData?id=$meetingId';
    final _response = await this.httpClient.get(_url);

    if (_response.statusCode != 200) {
      throw Exception('error getting menu for location');
    }

    final responseJson = jsonDecode(_response.body);
    return (responseJson as List).map((e) => e == null ? null : MeetingStreamModel.fromJson(e as Map<String, dynamic>))?.toList();
  }

}
