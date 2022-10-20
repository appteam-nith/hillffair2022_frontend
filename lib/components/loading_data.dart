// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hillfair2022_frontend/utils/colors.dart';

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