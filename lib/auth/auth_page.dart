import 'package:flutter/material.dart';

import '../util/validator.dart';
import 'widget/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Auth Form Demo'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
              child: AuthForm(
                formTitle: 'Login',
                idLabel: 'LoginId',
                idHintLabel: 'example@medium.jp',
                loginIdValidator: EmailValidator('LoginId'),
                pwLabel: 'Password',
                pwHintLabel: 'password',
                passwordValidator: PasswordValidator('Password'),
                pwVisibilityEnabled: true,
                buttonLabel: 'Login',
                required: true,
              ),
            )
          )
        ),
      )
    );
  }
}