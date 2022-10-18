// ignore_for_file: prefer_const_constructors

import 'dart:async';
// import 'verify_email_page.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/models/userFeed/post_img_model.dart';
import 'package:hillfair2022_frontend/models/team_member_model.dart';
import 'package:hillfair2022_frontend/models/team_model.dart';
import 'package:hillfair2022_frontend/screens/bottomnav/nav.dart';
import 'package:hillfair2022_frontend/screens/userfeed/post.dart';
import 'package:hillfair2022_frontend/screens/userfeed/tabslider.dart';
import 'package:hillfair2022_frontend/screens/userfeed/userfeed.dart';

import 'package:hillfair2022_frontend/signUp_widget.dart';

import 'package:hillfair2022_frontend/sign_in.dart';
import 'package:hillfair2022_frontend/utils/snackbar.dart';


import 'package:hillfair2022_frontend/view_models/userFeed_viewModels/comment_view_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:hillfair2022_frontend/view_models/postUser_view_model.dart';
import 'utils/colors.dart';
import 'view_models/userFeed_viewModels/getComments_viewModels.dart';
import 'view_models/userFeed_viewModels/postLike_viewModel.dart';
import 'welcome_page.dart';

import 'package:hillfair2022_frontend/view_models/events_view_model.dart';
import 'package:hillfair2022_frontend/view_models/userFeed_viewModels/post_img_view_model.dart';
import 'package:hillfair2022_frontend/view_models/team_member_view_model.dart';
import 'package:hillfair2022_frontend/view_models/team_view_model.dart';
import 'package:hillfair2022_frontend/view_models/userFeed_viewModels/userFeed_view_model.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAPNoWbnGUaeRF8XnPU0-G_LJBRGB7UN7Y",
      appId: "1:868222655855:android:f1b62e82fec35fcb429c9a",
      messagingSenderId: "868222655855",
      projectId: "login-page-hillfare-96b32",
    ),
  );

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: SizedBox(
        child: Center(
          child: Text("Something Went Wrong!!!",
              style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  };

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

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
          ChangeNotifierProvider(create: (_) => PostLIkeViewModel()),
          ChangeNotifierProvider(create: (_) => GetCommentsViewModel()),
          ChangeNotifierProvider(create: (_) => GetCommentsViewModel()),
          ChangeNotifierProvider(create: (_) => PostCommentViewModel()),

          ChangeNotifierProvider(create: (_) => PostCommentViewModel()),
          // ChangeNotifierProvider(create: (_) => PostUserViewModel()),

        ],
        child: MaterialApp(
            scaffoldMessengerKey: Utils.messengerKey,
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              fontFamily: GoogleFonts.inter().fontFamily,
              primarySwatch: Colors.purple,
            ),
            home: AnimatedSplashScreen(
                duration: 2000,
                splashTransition: SplashTransition.scaleTransition,
                splash: Image(
                  image: AssetImage("assets/images/hillfairlogo.png"),
                ),
                splashIconSize: 500,
                nextScreen: MainPage())));
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: BottomNav(),

          body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something Went Wrong!'),
            );
          } else if (snapshot.hasData) {
            return BottomNav();
          } else {
            return WelcomePage();
          }
        },
      ),
    );

  }
}
