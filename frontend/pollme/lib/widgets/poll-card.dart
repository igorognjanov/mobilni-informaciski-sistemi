import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pollme/model/poll.dart';
import 'package:pollme/pages/poll-create-page.dart';

class PollCard extends StatelessWidget {
  final Poll poll;
  final bool showEdit;

  const PollCard({super.key, required this.poll, this.showEdit = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PollCreatePage(
                    poll: poll,
                    pollOptions: [],
                  ))),
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
