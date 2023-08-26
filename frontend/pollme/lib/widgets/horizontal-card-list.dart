import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pollme/widgets/poll-card.dart';

class HorizontalPollCardList extends StatelessWidget {
  final List<PollCard> pollCards;

  const HorizontalPollCardList(
      {super.key,
      required this.pollCards});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: pollCards.length,
            itemBuilder: (context, index) {
              return pollCards[index];
            },
          ),
        ),
      ),
    );
  }
}
