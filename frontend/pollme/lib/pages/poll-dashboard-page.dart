import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pollme/model/poll.dart';
import 'package:pollme/pages/poll-create-page.dart';
import 'package:pollme/widgets/poll-card.dart';
import 'package:pollme/widgets/stats.dart';

import '../main.dart';
import '../widgets/horizontal-card-list.dart';

class PollDashBoardPage extends StatefulWidget {
  const PollDashBoardPage({super.key});

  @override
  State<StatefulWidget> createState() => _PollDashBoardPageState();
}

class _PollDashBoardPageState extends State<PollDashBoardPage> {
  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const PollMeApplication()),
    );
  }

  void _navigateToPollCreatePage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const PollCreatePage()));
  }

  @override
  Widget build(BuildContext context) {
    List<PollCard> pollCards = [
      PollCard(poll: Poll(pollName: 'Poll 1', questionName: 'Hello world')),
      PollCard(poll: Poll(pollName: 'Poll 2', questionName: 'Hello world')),
      PollCard(poll: Poll(pollName: 'Poll 3', questionName: 'Hello world')),
    ];
    return Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _navigateToPollCreatePage(context),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100.0, 35),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    backgroundColor: Colors.black),
                child: const Text('Create'),
              ),
              const Row(
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
              )
            ],
          ),
        ),
        body: Column(
          children: [
            HorizontalPollCardList(pollCards: pollCards),
            Text('Stats'),
            Stats(),
          ],
        ));
  }
}
