import 'package:flutter/material.dart';

class ValidationAlert extends StatelessWidget {
  const ValidationAlert(this.alertText, {super.key});

  final String? alertText;

  @override
  Widget build(BuildContext context) {
    if (alertText == null) {
      return Container();
    }

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xfffff0f0),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              alertText!, style: const TextStyle(
                color: Color(0xffFF2012),
                fontSize: 14
              )
            ),
          ),
        ],
      ),
    );
  }
}