import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PollCardBox extends StatelessWidget {
  String? name;

  PollCardBox({super.key, this.name}) {}

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 10,
      child: SizedBox(
          width: 100,
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "250",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ],
          )),
    );
  }
}
