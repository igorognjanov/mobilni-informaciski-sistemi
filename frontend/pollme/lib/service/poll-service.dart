import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pollme/model/poll-option.dart';

import '../model/poll.dart';

String path = "http://10.0.2.2:8080/api/polls";

Future<void> createPoll(Poll poll, List<PollOption> pollOption) async {
  var url = Uri.parse(path); // replace with your API endpoint

  var data = {
    'pollName': 'value1',
    'questionName': 'value2',
    // add other key-value pairs
  };

  try {
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
    } else {
      print('Failed to post data. StatusCode: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
