import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';

class UnderMaintainance extends StatefulWidget {
  const UnderMaintainance({super.key});

  @override
  State<UnderMaintainance> createState() => _UnderMaintainanceState();
}

class _UnderMaintainanceState extends State<UnderMaintainance> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async{
        return false;
      }),
      child: Scaffold(
        backgroundColor: bgColor,
        body: Container(
          child: Center(
              child: Text(
            "App is Under Maintenance!!!",
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
        ),
      ),
    );
  }
}
