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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Color(colorCode),
      ),
      width: screenWidth / 1.2,
      height: screenHeight / 14,
      child: MaterialButton(
        textColor: Color(textColorCode),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.055,
          ),
        ),
      ),
    );
  }
}
