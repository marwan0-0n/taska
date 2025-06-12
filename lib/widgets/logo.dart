import 'package:flutter/material.dart';

class CircleLogo extends StatelessWidget {
  const CircleLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff7dd2ed),
        borderRadius: BorderRadius.circular(1000),
      ),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 15),
      height: 80,
      child: Image.asset("assets/images/TaskaLogoBG.png", fit: BoxFit.fill),
    );
  }
}
