import 'package:flutter/material.dart';

import '../../util/validator.dart';
import 'main_button.dart';
import 'required_text.dart';
import '../../util/validation_alert.dart';

// Color
const grey60 = Color(0xff9299A3);
const grey20 = Color(0xffE1E5EB);
const grey10 = Color(0xffF5F6F8);
const red = Color(0xffFF2012);

// TextStyle
const formTitleTextStyle = TextStyle(color: Colors.black, fontSize: 18);
const formLabelTextStyle = TextStyle(color: Colors.black, fontSize: 14);
const formInputTextStyle = TextStyle(color: Colors.black, fontSize: 16);
const hintTextStyle = TextStyle(color: grey60, fontSize: 16);
const cautionTextStyle = TextStyle(color: red, fontSize: 14);

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
    this.formTitle,
    this.idLabel,
    this.idHintLabel,
    this.loginIdValidator,
    this.pwLabel,
    this.pwHintLabel,
    this.passwordValidator,
    this.pwVisibilityEnabled = false,
    this.cautionLabel,
    this.buttonLabel,
    this.required = false,
    this.onPressed,
  });
  
  final String? formTitle;
  final String? idLabel;
  final String? idHintLabel;
  final StringValidator? loginIdValidator;
  final String? pwLabel;
  final String? pwHintLabel;
  final StringValidator? passwordValidator;
  final bool pwVisibilityEnabled;
  final String? cautionLabel;
  final String? buttonLabel;
  final bool required;
  final Future<void> Function({
    String id,
    String password,
  })? onPressed;
  
  AuthFormState createState() => AuthFormState();
}

class AuthFormState extends State<AuthForm> with WidgetsBindingObserver {
  late TextEditingController _loginIdCtrl;
  late TextEditingController _passwordCtrl;
  late TextEditingController _confirmationPasswordCtrl;
  bool _hiddenId = false;
  bool _hiddenPassword = true;

  String get _loginId => _loginIdCtrl.text;
  String get _password => _passwordCtrl.text;

  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _loginIdCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
    _confirmationPasswordCtrl = TextEditingController();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _loginIdCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmationPasswordCtrl.dispose();

    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _hiddenId = false;
      setState(() {});
    } else if (state == AppLifecycleState.inactive) {
      _hiddenId = true;
      _hiddenPassword = true;
      setState(() {});
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final loginIdValidator = widget.loginIdValidator?.validate(_loginId);
    final passwordValidator = widget.passwordValidator?.validate(_password);

    final validLoginId = loginIdValidator?.isValid ?? false;
    final validPassword = passwordValidator?.isValid ?? false;

    final showLoginIdError = _submitted && !validLoginId;
    final showPasswordError = _submitted && !validPassword;

    final submitEnabled = (widget.idLabel == null || validLoginId) &&
        (widget.pwLabel == null || validPassword);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Text(widget.formTitle ?? '', style: formTitleTextStyle,),),
        const SizedBox(height: 20,),
        if (widget.idLabel != null) 
          Row(
            children: [
              Text(widget.idLabel ?? '', style: formLabelTextStyle,),
              const SizedBox(width: 8,),
              if (widget.required) const RequiredText()
            ],
          ),
        if (widget.idLabel != null) 
          const SizedBox(height: 8,),
          SizedBox(
            height: 52,
            child: TextField(
              controller: _loginIdCtrl,
              style: formInputTextStyle,
              decoration: InputDecoration(
                filled: true,
                fillColor: grey10,
                hintText: widget.idHintLabel,
                hintStyle: hintTextStyle,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 14,),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: grey20),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onChanged: (value) => setState(() {}),
              obscureText: _hiddenId,
            ),
          ),
          const SizedBox(height: 5,),
          if (widget.idLabel != null && showLoginIdError)
            ValidationAlert(loginIdValidator?.text),
          if (widget.pwLabel != null && widget.idLabel != null)
            const SizedBox(height: 24),
          if (widget.pwLabel != null)
            Row(
              children: [
                Text(widget.pwLabel ?? '', style: formLabelTextStyle),
                const SizedBox(width: 8,),
                if (widget.required) const RequiredText(),
              ],
            ),
          if (widget.pwLabel != null)
            const SizedBox(height: 8,),
            SizedBox(
              height: 52,
              child: TextField(
                controller: _passwordCtrl,
                style: formInputTextStyle,
                obscureText: _hiddenPassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: grey10,
                  hintText: widget.pwHintLabel,
                  hintStyle: hintTextStyle,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 14,),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: grey20),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  suffixIcon: widget.pwVisibilityEnabled
                  ? GestureDetector(
                      onTap: _toggleVisibility,
                      child: Icon(
                        _hiddenPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 20,
                      ),
                    )
                  : null,
                ),
                onChanged: (value) => setState(() {}),
              ),
            ),
          const SizedBox(height: 5),
          if (widget.pwLabel != null && showPasswordError)
            ValidationAlert(passwordValidator?.text),
          if (widget.cautionLabel != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(widget.cautionLabel ?? '', style: cautionTextStyle),
            ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 29),
            child: MainButton(
              text: widget.buttonLabel ?? '',
              onPressed: () {
                setState(() {
                  _submitted = true;
                });

                if (!submitEnabled) {
                  // implement error handling (ex. showDialog)
                  return;
                }
                widget.onPressed?.call(
                  id: _loginId,
                  password: _password,
                );
              },
            ),
          ),
      ]
    );
  }

  void _toggleVisibility() {
    setState(() {
      _hiddenPassword = !_hiddenPassword;
    });
  }
}