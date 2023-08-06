import 'package:flutter/material.dart';

import 'custom_button.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 44,
    this.disabled = false,
    this.focusNode,
    this.textSize = 16,
  });

  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final bool disabled;
  final FocusNode? focusNode;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomButton(
        text: text,
        textSize: textSize,
        textColor: Colors.white,
        backgroundColor: Colors.blue,
        focusNode: focusNode,
        onPressed: disabled ? null : onPressed,
      ),
    );
  }
}
