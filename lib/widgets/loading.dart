import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingSpinKit extends StatefulWidget {
  const LoadingSpinKit({super.key});

  @override
  State<LoadingSpinKit> createState() => _LoadingSpinKitState();
}

class _LoadingSpinKitState extends State<LoadingSpinKit> {
  final spinningLinesPainter = const SpinKitSpinningLines(color: Colors.black);
  @override
  Widget build(BuildContext context) {
    return Center(child: spinningLinesPainter);
  }
}
