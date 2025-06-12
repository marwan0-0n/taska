import 'package:flutter/material.dart';

class CustDivider extends StatelessWidget {
  const CustDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: const Text(
            "Or",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xffB0B0B0),
            ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
