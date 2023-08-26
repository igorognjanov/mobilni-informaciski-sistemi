import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pollme/model/poll.dart';

class PollCard extends StatelessWidget {
  final Poll poll;
  final bool showEdit;
  final Function(BuildContext context, Poll? poll) navigateCallback;

  const PollCard(
      {super.key,
      required this.poll,
      required this.navigateCallback,
      this.showEdit = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateCallback(context, poll),
      child: Card(
        elevation: 10,
        child: SizedBox(
            width: 100,
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: 10,
                  child: ColoredBox(color: Colors.blueAccent),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(poll.pollName),
                const IconButton(onPressed: null, icon: Icon(Icons.edit))
              ],
            )),
      ),
    );
  }
}
