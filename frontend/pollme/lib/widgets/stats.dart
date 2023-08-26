import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pollme/widgets/poll-card-box.dart';
import 'package:pollme/widgets/poll-card.dart';

import '../model/poll.dart';

class Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                  child: Column(children: [
                const Text(
                  'Total Answers',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                PollCardBox()
              ])),
            ),
          ),
          Card(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
                child: Column(children: [
              const Text(
                'Most anwsered poll',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              // PollCard(
              //   poll: Poll(pollName: 'Poll 2', questionName: ''),
              //   showEdit: false,
              // )
            ])),
          ))
        ],
      ),
    );
  }
}
