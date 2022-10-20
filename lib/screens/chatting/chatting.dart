// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';
import 'chat.dart';

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
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/images/bg.png"),
          //     fit: BoxFit.cover,
          //   ),
          // ),
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
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Container(
                            padding: EdgeInsets.all(50),
                        child: Text(
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
                    child: Text(
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
                          height: 350,
                          child: Container(
                            margin: EdgeInsets.all(20),
                            color: Colors.transparent,
                            width: 100,
                            height: 40,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ElevatedButton(
                                  child: Text(
                                      "I Agree",
                                      style: TextStyle(fontSize: 16)
                                  ),
                                  style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(15)),
                                              side: BorderSide(color: Colors.black54)
                                          )
                                      )
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) => PopDialogueBox(),
                                    );
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => const Chat()),
                                    // );
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



class PopDialogueBox extends StatefulWidget {
  const PopDialogueBox({Key? key}) : super(key: key);

  @override
  State<PopDialogueBox> createState() => PopDialogueBoxState();
}

class PopDialogueBoxState extends State<PopDialogueBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      title: const Text(
        'Searching for user',
        style: TextStyle(
          color: Colors.deepPurple,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            color: Colors.purpleAccent,
          )

        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Chat()),
            );
          },
          // textColor: Theme.of(context).primaryColor,
          child: const Text(
            'Start',
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}