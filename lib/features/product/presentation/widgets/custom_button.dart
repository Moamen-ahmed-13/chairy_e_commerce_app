import 'package:flutter/material.dart';

import '../../../../constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text, required this.onPressed,
  });
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: mainColor,
      minWidth: double.infinity,
      elevation: 0,
      height: 45,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
