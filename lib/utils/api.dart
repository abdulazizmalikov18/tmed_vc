import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

Future<String> fetchToken(BuildContext context) async {
  return Future.delayed(
    const Duration(milliseconds: 100),
    () =>
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiI1NGFlMzdkYS02NjBlLTQ5MzgtODJhNC04YjQxOTAzYjg2OTciLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTcxMTUyODM0NSwiZXhwIjoxNzQzMDY0MzQ1fQ.iPtbuHFifORgJ0NuIWCy4yZnFUkBbd3LMGMh2FH-o3I",
  );
}

Future<String> createMeeting(String token) async {
  const String videosdkApiEndpoint = "https://api.videosdk.live/v2";

  final Uri getMeetingIdUrl = Uri.parse('$videosdkApiEndpoint/rooms/');
  final http.Response meetingIdResponse =
      await http.post(getMeetingIdUrl, headers: {
    "Authorization": token,
  });

  if (meetingIdResponse.statusCode != 200) {
    throw Exception(json.decode(meetingIdResponse.body)["error"]);
  }
  var meetingID = json.decode(meetingIdResponse.body)['roomId'];
  return meetingID;
}

Future<bool> validateMeeting(String token, String meetingId) async {
  const String videosdkApiEndpoint = "https://api.videosdk.live/v2";

  final Uri validateMeetingUrl =
      Uri.parse('$videosdkApiEndpoint/rooms/validate/$meetingId');
  final http.Response validateMeetingResponse = await http.get(
    validateMeetingUrl,
    headers: {
      "Authorization": token,
    },
  );

  if (validateMeetingResponse.statusCode != 200) {
    throw Exception(json.decode(validateMeetingResponse.body)["error"]);
  }

  return validateMeetingResponse.statusCode == 200;
}

Future<dynamic> fetchSession(String token, String meetingId) async {
  const String videosdkApiEndpoint = "https://api.videosdk.live/v2";

  final Uri getMeetingIdUrl =
      Uri.parse('$videosdkApiEndpoint/sessions?roomId=$meetingId');
  final http.Response meetingIdResponse = await http.get(
    getMeetingIdUrl,
    headers: {
      "Authorization": token,
    },
  );
  List<dynamic> sessions = jsonDecode(meetingIdResponse.body)['data'];
  return sessions.first;
}

Future<dynamic> fetchActiveHls(String token, String meetingId) async {
  const String videosdkApiEndpoint = "https://api.videosdk.live/v2";

  final Uri getActiveHlsUrl =
      Uri.parse('$videosdkApiEndpoint/hls/$meetingId/active');
  final http.Response response = await http.get(
    getActiveHlsUrl,
    headers: {
      "Authorization": token,
    },
  );
  Map<dynamic, dynamic> activeHls = jsonDecode(response.body)['data'];
  return activeHls;
}

Future<dynamic> fetchHls(String url) async {
  final http.Response response = await http.get(Uri.parse(url));
  log(response.body);
  return response.statusCode;
}
