import 'dart:convert';
import 'dart:async';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class MeetingApiClient {
  static const baseUrl = 'http://parlvucloud.parl.gc.ca/';
  final http.Client httpClient;

  MeetingApiClient({@required this.httpClient}) : assert(httpClient != null);

}
