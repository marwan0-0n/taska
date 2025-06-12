import 'package:flutter/material.dart';
import 'dart:math';

class AppbarTitles extends StatefulWidget {
  const AppbarTitles({super.key});

  @override
  State<AppbarTitles> createState() => _AppbarTitlesState();
}

class _AppbarTitlesState extends State<AppbarTitles> {
  List<String> titles = [
    "Achieve More Today",
    "Your Journey Starts Here",
    "One Step Closer",
    "Dream. Build. Grow.",
    "Make It Happen",
    "Rise and Shine",
    "Inspire Your Day",
    "Unlock Your Potential",
  ];
  late String randomTitle;
  @override
  void initState() {
    super.initState();
    var random = Random();
    int min = 0;
    int max = titles.length - 1;
    int randomNumber = min + random.nextInt(max - min + 1);
    randomTitle = titles[randomNumber];
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      randomTitle,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
