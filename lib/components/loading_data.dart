import 'package:flutter/material.dart';

class LoadingData extends StatelessWidget {
  const LoadingData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}