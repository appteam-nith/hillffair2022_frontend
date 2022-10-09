import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/models/post_img_model.dart';
import 'package:hillfair2022_frontend/models/team_member_model.dart';
import 'package:hillfair2022_frontend/models/team_model.dart';
import 'package:hillfair2022_frontend/screens/bottomnav/nav.dart';
import 'package:hillfair2022_frontend/view_models/events_view_model.dart';
import 'package:hillfair2022_frontend/view_models/post_img_view_model.dart';
import 'package:hillfair2022_frontend/view_models/team_member_view_model.dart';
import 'package:hillfair2022_frontend/view_models/team_view_model.dart';
import 'package:hillfair2022_frontend/view_models/userFeed_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventsViewModel()),
        ChangeNotifierProvider(create: (_) => TeamViewModel()),
        ChangeNotifierProvider(create: (_) => TeamMemberViewModel()),
        ChangeNotifierProvider(create: (_) => UserFeedViewModel()),
        ChangeNotifierProvider(create: (_) => PostImgViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BottomNav(),
      ),
    );
  }
}
