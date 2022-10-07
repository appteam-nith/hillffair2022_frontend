import 'package:flutter/cupertino.dart';

class LoadingData extends StatelessWidget {
  const LoadingData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: const CupertinoActivityIndicator(),
      ),
    );
  }
}