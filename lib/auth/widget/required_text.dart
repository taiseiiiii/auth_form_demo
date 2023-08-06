import 'package:flutter/material.dart';

class RequiredText extends StatelessWidget {
  const RequiredText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      width: 45,
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: const Center(
        child: Text(
          'Required',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
