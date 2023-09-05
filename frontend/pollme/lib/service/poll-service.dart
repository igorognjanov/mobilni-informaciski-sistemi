import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pollme/model/poll-option.dart';
import 'package:pollme/service/shared-prefences.dart';

import '../model/poll.dart';

String poll_path = "http://10.0.2.2:8080/api/polls";
String poll_options_path = "http://10.0.2.2:8080/api/poll-options";
String poll_answers = "http://10.0.2.2:8080/api/poll-answers";

Future<List<PollOption>> findPollOptions(BigInt pollId) async {
  var token = await getToken();
  var url = Uri.parse('$poll_options_path/$pollId');
  var response =
      await http.get(url, headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => PollOption.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load poll options');
  }
}

Future<List<Poll>> findPolls() async {
  var token = await getToken();
  var url = Uri.parse(poll_path);
  var response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $token'},
  );
  print('getting polls');

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return jsonResponse.map((data) => Poll.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load polls');
  }
}

Future<void> createPoll(Poll poll, List<PollOption> pollOptions) async {
  var url = Uri.parse(poll_path);
  var token = await getToken();
  try {
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(poll.toJson()));

    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
      BigInt pollId = BigInt.parse(response.body);
      pollOptions.forEach((element) {
        element.pollId = pollId;
      });
      await createPollOption(pollOptions);
      // return Future.delayed(const Duration(seconds: 10));
    } else {
      print('Failed to post data. StatusCode: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> createPollOption(List<PollOption> pollOptions) async {
  var url = Uri.parse(poll_options_path);
  var token = await getToken();
  try {
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(pollOptions.map((e) => e.toJson()).toList()),
    );

    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
    } else {
      print('Failed to post data. StatusCode: ${response.statusCode}');
    }
  } catch (e) {
    print('Error $e');
  }
}

Future<void> votePoll(BigInt pollOptionId) async {
  var token = await getToken();
  var url = Uri.parse('$poll_answers/$pollOptionId');
  var response =
      await http.put(url, headers: {'Authorization': 'Bearer $token'});
  if (response.statusCode == 200) {
    print('Voted poll: ${response.body}');
  }
}

// Future<http.Response> getWithToken(String url) async {
//   final response = await http.get(
//     Uri.parse(url),
//     headers: {'Authorization': 'Bearer $token'},
//   );
//   return response;
// }
