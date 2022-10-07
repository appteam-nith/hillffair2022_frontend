import 'package:flutter/material.dart';
import 'package:hillfair22_3rdyear/screens/bottomnav/nav.dart';
import 'package:hillfair22_3rdyear/screens/events/events.dart';
import 'package:hillfair22_3rdyear/screens/team/teamlist.dart';
import 'package:hillfair22_3rdyear/screens/team/teammembers.dart';
import 'package:hillfair22_3rdyear/screens/userfeed/userfeed.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNav(),
    );
  }
}
