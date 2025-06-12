import 'package:flutter/material.dart';

class CustButtom extends StatelessWidget {
  final int colorCode;
  final String text;
  final void Function()? onPressed;
  final int textColorCode;
  const CustButtom({
    super.key,
    required this.colorCode,
    required this.text,
    this.onPressed,
    required this.textColorCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Color(colorCode),
      ),
      width: 340,
      height: 60,
      child: MaterialButton(
        textColor: Color(textColorCode),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
