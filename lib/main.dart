import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:hillffair2022_frontend/icons.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'r',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text('feed',
        style: optionStyle),
    Text('chatting',
        style: optionStyle),
    Text('home',
        style: optionStyle),
    Text('wallet',
        style: optionStyle),
    Text('profile',
        style: optionStyle),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      backgroundColor: const Color(0xFF3E2723),
      //backgroundColor: Colors.green.shade900,
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        buttonBackgroundColor: Colors.white30.withOpacity(0.4),
        backgroundColor: const Color(0xFF3E2723),
        color: Colors.white30.withOpacity(0.4),
        animationCurve: Curves.easeInOut.flipped,
        animationDuration: const Duration(milliseconds: 350),
        items:  [
          Container(
              margin:  const EdgeInsets.all(0),
              width: 50,
              height: 50,
              decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                      colors:[
                        Colors.white,Colors.white30.withOpacity(0),
                      ]
                  )
              ),
              child: Icon(
                CustomAppIcon.feed, color: Colors.black,
                size: (_selectedIndex == 0) ? 30 : 30,
              )

          ),
          Container(
              margin: const EdgeInsets.all(0),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                      colors:[
                        Colors.white,Colors.white30.withOpacity(0),
                      ]
                  )
              ),
              child: Icon(
                CustomAppIcon.chat, color: Colors.black,
                size: (_selectedIndex == 1) ? 35 : 30,
              )
          ),
          Container(
              margin: const EdgeInsets.all(0),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                      colors:[
                        Colors.white,Colors.white30.withOpacity(0),
                      ]
                  )
              ),
              child: Icon(
                CustomAppIcon.home, color: Colors.black,
                size: (_selectedIndex == 2) ? 30 : 30,
              )
          ),
          Container(
              margin: const EdgeInsets.all(0),
              width: 50,
              height: 50,
              decoration:  BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors:[
                    Colors.white,Colors.white30.withOpacity(0),
                  ],
                ),

              ),
              child: Icon(
                CustomAppIcon.groups, color: Colors.black,
                size: (_selectedIndex == 3) ? 30: 30,
              )
          ),
          Container(
              margin: const EdgeInsets.all(0),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                      colors:[
                        Colors.white,Colors.white30.withOpacity(0),
                      ]
                  )
              ),
              child: Icon(
                CustomAppIcon.profile, color: Colors.black,
                size: (_selectedIndex == 4) ? 30 : 30,
              )
          ),


        ],
        onTap: _onItemTapped,
      ),
    );
  }
}