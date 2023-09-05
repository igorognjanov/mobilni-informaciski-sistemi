import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/poll-option.dart';
import '../model/poll.dart';
import '../service/poll-service.dart';

class VotePage extends StatefulWidget {
  final Poll poll;

  VotePage({super.key, required this.poll});

  @override
  State<StatefulWidget> createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  BigInt? _selectedOption;
  List<PollOption> pollOptions = [];

  @override
  void initState() {
    super.initState();
    _fetchPollOptions();
  }

  void _fetchPollOptions() async {
    try {
      List<PollOption> options = await findPollOptions(widget.poll!.id!);
      setState(() {
        // _options = options.map((e) => e.name).toList();
        pollOptions = options;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: null,
                icon: Icon(Icons.poll, color: Colors.black, size: 34)),
            Text('Poll Me',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black))
          ],
        )),
        body: pollOptions.isNotEmpty
            ? ListView.builder(
                itemCount: pollOptions.length,
                itemBuilder: (context, index) {
                  PollOption option = pollOptions[index];
                  return ListTile(
                    title: Text(option.name),
                    leading: Radio<BigInt>(
                      value: option.id!,
                      groupValue: _selectedOption,
                      onChanged: (BigInt? value) {
                        setState(() {
                          _selectedOption = value;
                          votePoll(option.id!);
                          Navigator.pop(context);
                        });
                      },
                    ),
                  );
                },
              )
            : Text("No poll options for this poll"));
  }
}
