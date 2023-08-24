import 'package:flutter/material.dart';
import 'package:pollme/AppBar/app-bar.dart';
import 'package:pollme/pages/login-page.dart';
import 'package:pollme/pages/register-page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poll Me',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.white, // Set the app bar color to white
          iconTheme: IconThemeData(
              color: Colors.black), // Set the app bar icon color to black
        ),
      ),
      home: const PollMeApplication(),
    );
  }
}

class PollMeApplication extends StatefulWidget {
  const PollMeApplication({super.key});

  @override
  State<PollMeApplication> createState() => _PollMeApplicationState();
}

class _PollMeApplicationState extends State<PollMeApplication> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return const Scaffold(
      appBar: PollMeAppBar(),
      body: LoginPage(),
    );
  }
}
