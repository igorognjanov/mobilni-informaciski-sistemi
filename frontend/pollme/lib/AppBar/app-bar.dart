import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PollMeAppBar extends StatelessWidget implements PreferredSizeWidget {

  const PollMeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 4,
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
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
