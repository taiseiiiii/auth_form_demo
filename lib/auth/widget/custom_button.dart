import 'package:flutter/material.dart';

class CustomButton extends TextButton {
  CustomButton({
    super.key,
    required this.text,
    this.textSize = 16,
    required this.textColor,
    required this.backgroundColor,
    this.borderColor,
    super.focusNode,
    required super.onPressed,
    this.icon,
  }) : super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: icon,
                ),
              Text(
                text,
                style: TextStyle(
                  fontSize: textSize,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontFamily: 'Noto Sans JP',
                ),
              ),
            ],
          ),
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            side: borderColor == null ? null : BorderSide(color: borderColor),
            elevation: 0,
            padding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(37),
              ),
            ),
          ),
        );

  final String text;
  final double textSize;
  final Color textColor;
  final Color backgroundColor;
  final Color? borderColor;
  final Widget? icon;
}
