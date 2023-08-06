abstract class StringValidator {
  ValidationResult validate(String value);
}

RegExp _halfSizeRegExp = RegExp(r'^[!-~]*$');

RegExp _passwordRegExp = RegExp(
  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!-\/:-@\[-`{-~]).{10,}$',
);

RegExp _emailRegExp = RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
);

class ValidationResult {
  ValidationResult({this.isValid = false, this.text});
  final bool isValid;
  final String? text;
}

class PasswordValidator implements StringValidator {
  PasswordValidator(this.label, {this.max = 128});
  final String label;
  final int max;

  @override
  ValidationResult validate(String value) {
    if (value.isEmpty) {
      return ValidationResult(text: 'Please enter $label');
    }

    if (!_halfSizeRegExp.hasMatch(value)) {
      return ValidationResult(text: '$label Contains non-half-width characters');
    }

    if (!_passwordRegExp.hasMatch(value)) {
      return ValidationResult(text: '$label must be at least 10 characters, including at least one upper-case alphabetical letter, one lower-case alphabetical letter, one numeric character, and one symbol.');
    }

    if (value.length > max) {
      return ValidationResult(text: '$label is less than or equal to $max characters');
    }

    return ValidationResult(isValid: true);
  }
}

class EmailValidator implements StringValidator {
  EmailValidator(this.label);
  final String label;

  @override
  ValidationResult validate(String value, {List<String>? targets}) {
    if (value.isEmpty) {
      return ValidationResult(text: 'Please enter $label');
    }

    if (!_emailRegExp.hasMatch(value)) {
      return ValidationResult(text: 'Please enter the correct $label');
    }

    return ValidationResult(isValid: true);
  }
}