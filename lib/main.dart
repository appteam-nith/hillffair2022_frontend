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
import 'package:hillfair2022_frontend/screens/profile/edit_profile.dart';
import 'package:hillfair2022_frontend/screens/profile/postuser.dart';
import 'package:hillfair2022_frontend/screens/userfeed/post.dart';
import 'package:hillfair2022_frontend/screens/userfeed/tabslider.dart';
import 'package:hillfair2022_frontend/screens/userfeed/userfeed.dart';

import 'package:hillfair2022_frontend/signUp_widget.dart';

import 'package:hillfair2022_frontend/sign_in.dart';
import 'package:hillfair2022_frontend/utils/snackbar.dart';
// import 'package:hillfair2022_frontend/verify_email_page.dart';

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
      apiKey: "AIzaSyATOS_lE0LVWg3U9F8tqeME8jAs6HDCPC0",
      appId: "1:424848973372:android:9ee175274e54861eebed39",
      messagingSenderId: "424848973372",
      projectId: "hillfare2k22-2",
    ),
  );

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: SizedBox(
        child: Center(
          child: Text("Something Went Wrong!!!",
              style: TextStyle(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  };

  runApp(RestartWidget(child:  MyApp()));
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
   MainPage({super.key});
  // bool isEmailVerified=FirebaseAuth.instance.currentUser!.emailVerified;
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
            // return PostUser(snapshot.data!.email, snapshot.data!.uid);
            // if (isEmailVerified==true) {
            return BottomNav();
            // } else {
            //   return VerifyEmailPage();
            // }
          } else {
            return WelcomePage();
          }
        },
      ),
    );
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
