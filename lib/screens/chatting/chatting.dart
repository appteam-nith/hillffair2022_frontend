import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/api_services/chatting_services.dart';
import 'package:hillfair2022_frontend/screens/chatting/chatlist.dart';
import 'package:hillfair2022_frontend/screens/chatting/start_Chatting.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'upcoming.dart';


class Chatting extends StatefulWidget {
  const Chatting({super.key});

  @override
  State<Chatting> createState() => _Chatting();
}

class _Chatting extends State<Chatting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
          color: bgColor,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        height: 380.0,
                        width: 320.0,
                        color: Colors.transparent,
                        child: Container(
                          alignment: Alignment.topCenter,
                          decoration:const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                          child:Container(
                            padding: EdgeInsets.all(20),
                            child: const Text(
                              'Guidlines',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(60),
                        child: const Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
                              ' sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                              ' Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi'
                              ' ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit '
                              'in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 16,
                            //fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                          width: 500,
                          height: 380,
                          child: Container(
                            margin: EdgeInsets.all(15),
                            color: Colors.transparent,
                            width: 100,
                            height: 40,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ElevatedButton(
                                  child:  Text(
                                      "I Agree",
                                      style: TextStyle(fontSize: 16)
                                  ),
                                  style: ButtonStyle(
                                  splashFactory: NoSplash.splashFactory,
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                          )
                                      )
                                  ),
                                  onPressed: () {

                                // showDialog(
                                //   context: context,
                                //   builder: (BuildContext context) => const Upcoming(),
                                    // );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Upcoming()),
                                );
                                  }
                              ),
                            ),
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        )
    );
  }
}