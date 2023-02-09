import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hillfair2022_frontend/components/loading_data.dart';
import 'package:hillfair2022_frontend/screens/bottomnav/nav.dart';
import 'package:hillfair2022_frontend/screens/register/sign_in.dart';
import 'package:hillfair2022_frontend/screens/welcome/under_maintainance.dart';
import 'package:hillfair2022_frontend/utils/global.dart';
import 'package:hillfair2022_frontend/utils/snackbar.dart';
import 'package:hillfair2022_frontend/view_models/teamFeed_view_model/teamFeedList_view_model.dart';
import 'package:hillfair2022_frontend/view_models/userFeed_viewModels/comment_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/forgot_password/verify_email_page.dart';
import 'utils/colors.dart';
import 'view_models/userFeed_viewModels/get_comments_view_model.dart';
import 'view_models/userFeed_viewModels/post_like_view_model.dart';
import 'package:hillfair2022_frontend/view_models/event_view_model/events_view_model.dart';
import 'package:hillfair2022_frontend/view_models/userFeed_viewModels/post_img_view_model.dart';
import 'package:hillfair2022_frontend/view_models/team_view_model/team_member_view_model.dart';
import 'package:hillfair2022_frontend/view_models/team_view_model/team_view_model.dart';
import 'package:hillfair2022_frontend/view_models/userFeed_viewModels/user_feed_view_model.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  Globals.email = preferences.getString("useremail");
  Globals.password = preferences.getString("userpass");
  Globals.isuserhavedata = preferences.getBool("isuserdatapresent");
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

  runApp(RestartWidget(child: MyApp()));
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
          ChangeNotifierProvider(create: (_) => TeamFeedViewModel())
        ],
        child: MaterialApp(
          scaffoldMessengerKey: Utils.messengerKey,
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Hillffair',
          theme: ThemeData(
            fontFamily: GoogleFonts.inter().fontFamily,
            primarySwatch: Colors.purple,
          ),
          home: EasySplashScreen(
            logoWidth: 200,
            logo: Image(
              image: AssetImage("assets/images/hillfairlogo.png"),
            ),
            navigator: MainPage(),
            durationInSeconds: 2,
            showLoader: false,
            loadingText: Text(
              "Developed by AppTeam",
              style: TextStyle(color: Colors.white),
            ),
            loaderColor: Colors.white,
            backgroundColor: bgColor,
          ),
        ));
  }
}

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  StreamSubscription? internetconnection;

  getdata() async {
    final res = await ref.child("appCrashed").get();
    return res.value;
  }

  @override
  void initState() {
    internetconnection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        showDialogBox(context);
      }
    });

    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    // internetconnection!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getdata(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          print(data);

          if (data == false) {
            return Scaffold(
              backgroundColor: bgColor,
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
                    bool isEmailVerified =
                        FirebaseAuth.instance.currentUser!.emailVerified;
                    if (isEmailVerified == true) {
                      return BottomNav();
                    } else {
                      return VerifyEmailPage();
                    }
                  } else {
                    return SignIn();
                  }
                },
              ),
            );
          } else {
            return UnderMaintainance();
          }
        }
        return Scaffold(
          backgroundColor: bgColor,
          body: LoadingData(),
        );
      }
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

showDialogBox(context) => showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('No Connection'),
        content: const Text('Please check your internet connectivity'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
