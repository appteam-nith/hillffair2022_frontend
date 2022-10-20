import 'package:flutter/material.dart';
class Upcoming extends StatefulWidget {
  const Upcoming({Key? key}) : super(key: key);

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/bg.png"),
                    fit: BoxFit.cover)
            ),
          ),
          Container(
            height: 30.0,
            width: 40.0,
            color: Colors.transparent,
            child: IconButton(
                iconSize: 30,
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () =>
                    Navigator.of(context).pop()
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget> [
                Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        height: 200.0,
                        width: 320.0,
                        color: Colors.transparent,
                        child: Container(
                          alignment: Alignment.center,
                          decoration:const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                          child:Container(
                            alignment: Alignment.center,
                            //padding: EdgeInsets.all(60),
                            child: const Text(
                              'Coming Soon!',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ]
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}